// Imports the vector_math package for Matrix4, Vector3, etc.
import 'package:vector_math/vector_math_64.dart';

// Represents an SVG command (e.g. 'M', 'L', 'C') along with numeric data
class PathCommand {
  String command; // Command type (e.g. 'M')
  List<double> data; // Coordinates or other parameters

  PathCommand(this.command, this.data);
}

// Scales the SVG path by a given factor
String scaleSvgPath(String pathData, double scale) {
  // Parse the path string into commands
  final commands = parseSvgPathData(pathData);

  // Build a scale matrix (uniform scale in x and y directions)
  final scaleMatrix = Matrix4.identity()..scale(scale, scale);

  // Apply the scaling to each coordinate pair
  for (final command in commands) {
    for (int i = 0; i < command.data.length; i += 2) {
      final point = Vector3(command.data[i], command.data[i + 1], 0)
        ..applyMatrix4(scaleMatrix);
      command.data[i] = point.x;
      command.data[i + 1] = point.y;
    }
  }

  // Reconstruct the SVG path string with updated coordinates
  return buildSvgPathData(commands);
}

// Parses the SVG path string into a list of PathCommand objects
List<PathCommand> parseSvgPathData(String pathData) {
  final commands = <PathCommand>[];
  // Regex extracting commands (M, L, C, etc.) and numbers (coordinates)
  final regex = RegExp(r'([MmLlHhVvCcSsQqTtAaZz])|(-?\d*\.?\d+(?:e[-+]?\d+)?)');
  final matches = regex.allMatches(pathData);

  String? currentCommand;
  final currentData = <double>[];

  // Go through each match; if it's a command, start a new PathCommand
  for (final match in matches) {
    final command = match.group(1);
    if (command != null) {
      // If we already have a command, finalize it before moving on
      if (currentCommand != null) {
        commands.add(PathCommand(currentCommand, List.from(currentData)));
        currentData.clear();
      }
      currentCommand = command;
    } else {
      // If it's a number, add it to the current list of coordinates
      final number = double.tryParse(match.group(2)!);
      if (number != null) {
        currentData.add(number);
      }
    }
  }

  // Add the last command found, if any
  if (currentCommand != null) {
    commands.add(PathCommand(currentCommand, currentData));
  }
  return commands;
}

// Builds the final SVG path string from a list of commands and their coords
String buildSvgPathData(List<PathCommand> commands) {
  final buffer = StringBuffer();
  for (final command in commands) {
    buffer.write(command.command);
    for (final num value in command.data) {
      buffer.write(' $value');
    }
  }
  // Trim to remove trailing whitespace
  return buffer.toString().trim();
}

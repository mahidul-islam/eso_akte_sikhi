import 'package:vector_math/vector_math_64.dart';

class PathCommand {
  String command;
  List<double> data;

  PathCommand(this.command, this.data);
}

String scaleSvgPath(String pathData, double scale) {
  final commands = parseSvgPathData(pathData);
  final scaleMatrix = Matrix4.identity()..scale(scale, scale);

  for (final command in commands) {
    for (int i = 0; i < command.data.length; i += 2) {
      final point = Vector3(command.data[i], command.data[i + 1], 0)
        ..applyMatrix4(scaleMatrix);
      command.data[i] = point.x;
      command.data[i + 1] = point.y;
    }
  }

  return buildSvgPathData(commands);
}

List<PathCommand> parseSvgPathData(String pathData) {
  final commands = <PathCommand>[];
  final regex = RegExp(r'([MmLlHhVvCcSsQqTtAaZz])|(-?\d*\.?\d+(?:e[-+]?\d+)?)');
  final matches = regex.allMatches(pathData);
  String? currentCommand;
  final currentData = <double>[];

  for (final match in matches) {
    final command = match.group(1);
    if (command != null) {
      if (currentCommand != null) {
        commands.add(PathCommand(currentCommand, List.from(currentData)));
        currentData.clear();
      }
      currentCommand = command;
    } else {
      final number = double.tryParse(match.group(2)!);
      if (number != null) {
        currentData.add(number);
      }
    }
  }
  if (currentCommand != null) {
    commands.add(PathCommand(currentCommand, currentData));
  }
  return commands;
}

String buildSvgPathData(List<PathCommand> commands) {
  final buffer = StringBuffer();
  for (final command in commands) {
    buffer.write(command.command);
    for (final num value in command.data) {
      buffer.write(' $value');
    }
  }
  return buffer.toString().trim();
}

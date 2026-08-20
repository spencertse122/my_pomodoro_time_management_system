import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class LocalModelPaths {
  const LocalModelPaths({required this.model, required this.projector});

  final String model;
  final String projector;
}

class ModelAssetLocator {
  const ModelAssetLocator();

  static const modelFileName = 'gemma-3-4b-it-q4_k_m.gguf';
  static const projectorFileName = 'mmproj-gemma-3-4b-it-f16.gguf';

  static const _configuredModel = String.fromEnvironment(
    'FOCUS_FLOW_MODEL_PATH',
  );
  static const _configuredProjector = String.fromEnvironment(
    'FOCUS_FLOW_MMPROJ_PATH',
  );

  Future<LocalModelPaths?> locate() async {
    final configured = _pairIfPresent(_configuredModel, _configuredProjector);
    if (configured != null) return configured;

    final support = await getApplicationSupportDirectory();
    final executable = File(Platform.resolvedExecutable);
    final executableDirectory = executable.parent.path;
    final candidates = <String>[
      p.join(support.path, 'models'),
      p.join(executableDirectory, 'data', 'flutter_assets', 'assets', 'models'),
      p.join(
        executableDirectory,
        '..',
        'Frameworks',
        'App.framework',
        'Resources',
        'flutter_assets',
        'assets',
        'models',
      ),
      p.join(Directory.current.path, 'assets', 'models'),
    ];

    for (final directory in candidates) {
      final pair = _pairIfPresent(
        p.normalize(p.join(directory, modelFileName)),
        p.normalize(p.join(directory, projectorFileName)),
      );
      if (pair != null) return pair;
    }
    return null;
  }

  Future<LocalModelPaths> locateOrExpected() async {
    final located = await locate();
    if (located != null) return located;
    final support = await getApplicationSupportDirectory();
    final directory = p.join(support.path, 'models');
    return LocalModelPaths(
      model: p.join(directory, modelFileName),
      projector: p.join(directory, projectorFileName),
    );
  }

  LocalModelPaths? _pairIfPresent(String model, String projector) {
    if (model.isEmpty || projector.isEmpty) return null;
    if (!File(model).existsSync() || !File(projector).existsSync()) return null;
    return LocalModelPaths(
      model: File(model).absolute.path,
      projector: File(projector).absolute.path,
    );
  }
}

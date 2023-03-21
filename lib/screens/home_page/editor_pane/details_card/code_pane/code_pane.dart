import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apidash/providers/providers.dart';
import 'package:apidash/widgets/widgets.dart';
import 'package:apidash/codegen/codegen.dart';
import 'package:apidash/consts.dart';

class CodePane extends ConsumerStatefulWidget {
  const CodePane({super.key});

  @override
  ConsumerState<CodePane> createState() => _CodePaneState();
}

class _CodePaneState extends ConsumerState<CodePane> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final activeId = ref.watch(activeIdStateProvider);
    final collection = ref.watch(collectionStateNotifierProvider);
    final idIdx = collection.indexWhere((m) => m.id == activeId);
    final requestModel = collection[idIdx];
    print("update");
    var codeTheme = Theme.of(context).brightness == Brightness.light
        ? kLightCodeTheme
        : kDarkCodeTheme;
    final textContainerdecoration = BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? Color.alphaBlend(
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
              Colors.black)
          : Color.alphaBlend(
              Theme.of(context).colorScheme.surface.withOpacity(0.2),
              Colors.white),
      border: Border.all(color: Theme.of(context).colorScheme.surfaceVariant),
      borderRadius: kBorderRadius8,
    );
    return Padding(
      padding: kP10,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              padding: kP8,
              decoration: textContainerdecoration,
              child: CodePreviewer(
                code: getDartHttpCode(requestModel),
                theme: codeTheme,
                language: 'dart',
                textStyle: kCodeStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

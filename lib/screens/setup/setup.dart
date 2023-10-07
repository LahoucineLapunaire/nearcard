import 'package:NearCard/blocs/setup/setup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupBloc(),
      child: Scaffold(
        body: BlocBuilder<SetupBloc, SetupInitial>(
          builder: (context, state) {
            return KeyedSubtree(
              key: ValueKey(state.currentPage),
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: PageController(
                  initialPage: state.currentPage,
                ),
                onPageChanged: (int page) {
                  print("onPageChanged");
                  context.read<SetupBloc>().add(SetupEventChange(page));
                },
                children: state.pages,
              ),
            );
          },
        ),
      ),
    );
  }
}

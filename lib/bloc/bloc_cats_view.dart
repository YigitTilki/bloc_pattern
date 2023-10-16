import 'package:bloc_pattern/bloc/cats_cubit.dart';
import 'package:bloc_pattern/bloc/cats_repository.dart';
import 'package:bloc_pattern/bloc/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCatsView extends StatefulWidget {
  const BlocCatsView({super.key});

  @override
  State<BlocCatsView> createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatsCubit(SampleCatsRepository()),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        //floatingActionButton: buildFloatingActionButtonCall(context),
        appBar: AppBar(
          title: const Text("Hello"),
        ),
        body: BlocConsumer<CatsCubit, CatsState>(
          listener: (context, state) {
            if (state is CatsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CatsInitial) {
              return buildCenterInitialChild(context);
            } else if (state is CatsLoading) {
              return buildCenterLoading();
            } else if (state is CatsCompleted) {
              return buildListViewCats(state);
            } else {
              return buildError(state);
            }
          },
        ),
      );

  Text buildError(CatsState state) {
    final error = state as CatsError;
    return Text(error.message);
  }

  ListView buildListViewCats(CatsCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Image.network(
          state.response[index].imageUrl.toString(),
        ),
        subtitle: Text(
          state.response[index].description.toString(),
        ),
      ),
      itemCount: state.response.length,
    );
  }

  Center buildCenterLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center buildCenterInitialChild(BuildContext context) {
    return Center(
      child: Column(
        children: [const Text("Hello"), buildFloatingActionButtonCall(context)],
      ),
    );
  }

  FloatingActionButton buildFloatingActionButtonCall(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CatsCubit>().getCats();
      },
      child: const Icon(Icons.clear_all),
    );
  }
}

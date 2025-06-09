import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reels_app/features/presentation/bloc/reels_bloc.dart';
import 'package:reels_app/features/presentation/widget/reel_item.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  ReelsScreenState createState() => ReelsScreenState();
}

class ReelsScreenState extends State<ReelsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<ReelsBloc>().state;
      if (state is ReelsLoaded && !state.hasReachedMax) {
        context.read<ReelsBloc>().add(FetchReelsEvent(
            page: context.read<ReelsBloc>().currentPage));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels',style: TextStyle(color: Colors.white),),),
      body: BlocBuilder<ReelsBloc, ReelsState>(
        builder: (context, state) {
          if (state is ReelsInitial || state is ReelsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReelsLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.reels.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.reels.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ReelItem(reel: state.reels[index]);
              },
            );
          } else if (state is ReelsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
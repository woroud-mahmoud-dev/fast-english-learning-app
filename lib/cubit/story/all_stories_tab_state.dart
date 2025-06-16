part of 'all_stories_tab_cubit.dart';

abstract class AllStoriesTabState {}

class AllStoriesTabInitial extends AllStoriesTabState {}


class AllStoriesLoading extends AllStoriesTabState {}
class AllStoriesError extends AllStoriesTabState {}
class AllStoriesDown extends AllStoriesTabState {}
class UserNotFound extends AllStoriesTabState {}

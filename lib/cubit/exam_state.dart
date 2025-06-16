part of 'exam_cubit.dart';

abstract class ExamState {}

class ExamInitial extends ExamState {}

class QuestionsLoading extends ExamState {}
class QuestionsError extends ExamState {}
class QuestionsDown extends ExamState {}

class SendResultLoading extends ExamState {}
class SendResultError extends ExamState {}
class SendResultDown extends ExamState {}


class SelectedLevel extends ExamState {}
class ExamUpdate extends ExamState {}

class ExamFinish extends ExamState {}
class ExamEmpty extends ExamState {}

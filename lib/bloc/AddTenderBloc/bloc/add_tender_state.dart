part of 'add_tender_bloc.dart';

@immutable
abstract class AddTenderState {}
abstract class AddTenderActionState extends AddTenderState{}
class AddTenderInitial extends AddTenderState {}
class NavigatePop extends AddTenderActionState{}

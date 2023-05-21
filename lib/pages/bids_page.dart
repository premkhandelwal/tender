import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vender/logic/bloc/AddTenderBloc/add_tender_bloc.dart';
import 'package:vender/models/quotes.dart';
import 'package:vender/routes/arguments/screen_args.dart';

class TenderBigsPage extends StatefulWidget {
  const TenderBigsPage({
    Key? key,
  }) : super(key: key);

  @override
  TenderBigsPageState createState() => TenderBigsPageState();
}

late AddTenderBloc addTenderBloc;

class TenderBigsPageState extends State<TenderBigsPage> {
  List<Quotes> pendingQuotesList = [];
  List<Quotes> acceptedQuotesList = [];
  List<Quotes> declinedQuotesList = [];
  @override
  void initState() {
    super.initState();
    addTenderBloc = BlocProvider.of<AddTenderBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BidsScreenArgs;
    addTenderBloc.add(FetchQuotesEvent(tenderId: args.tender.tenderId!));
    return WillPopScope(
      onWillPop: () async {
        addTenderBloc.add(FetchPreviousTenders());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocConsumer<AddTenderBloc, AddTenderState>(
            listener: (context, state) {
              if (state is AwardQuoteTenderSuccessState) {
                pendingQuotesList.remove(state.quote);
                if (state.accepted) {
                  acceptedQuotesList.add(state.quote);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Accepted quote")));
                } else {
                  declinedQuotesList.add(state.quote);

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Declined quote")));
                }
                // Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is FetchQuotesInProgressState ||
                  state is AwardQuoteTenderInProgressState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FetchQuotesSuccessState) {
                pendingQuotesList = state.quotesList["pendingQuotesList"]!;
                acceptedQuotesList = state.quotesList["acceptedQuotesList"]!;
                declinedQuotesList = state.quotesList["declinedQuotesList"]!;
              }
              if (state is FetchQuotesFailureState) {
                return const Text(
                    "Failed to fetch bids. Please try again later.");
              }
              return pendingQuotesList.isEmpty &&
                            acceptedQuotesList.isEmpty &&
                            declinedQuotesList.isEmpty
                        ? Center(
                            child: Text(
                              "No Quotes found",
                              style: GoogleFonts.lato(
                                letterSpacing: 0.5,
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          )
                        :  SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    pendingQuotesList.isNotEmpty
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Pending Quotes",
                                style: GoogleFonts.lato(
                                    letterSpacing: 0.5,
                                    textStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ),
                              const SizedBox(height: 5),
                              QuoteTile(
                                  pendingQuotesList: pendingQuotesList,
                                  isPending: true),
                              const SizedBox(height: 25),
                            ],
                          )
                        : Container(),
                    acceptedQuotesList.isNotEmpty
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Accepted Quotes",
                                  style: GoogleFonts.lato(
                                      letterSpacing: 0.5,
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black))),
                              const SizedBox(height: 5),
                              QuoteTile(pendingQuotesList: acceptedQuotesList),
                              const SizedBox(height: 25),
                            ],
                          )
                        : Container(),
                    declinedQuotesList.isNotEmpty
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Declined Quotes",
                                  style: GoogleFonts.lato(
                                      letterSpacing: 0.5,
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black))),
                              QuoteTile(pendingQuotesList: declinedQuotesList),
                            ],
                          )
                        : Container(),
                    
                  ],
                ),
              );
            },
          ),
        )),
      ),
    );
  }
}

class QuoteTile extends StatelessWidget {
  final bool isPending;
  const QuoteTile({
    Key? key,
    this.isPending = false,
    required this.pendingQuotesList,
  }) : super(key: key);

  final List<Quotes> pendingQuotesList;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        // padding: EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: pendingQuotesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: const Color(0xffe4d3e8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 9,
                child: ListTile(
                  onTap: () async {},
                  title: Text(
                    pendingQuotesList[index].userInfo.name,
                    style: GoogleFonts.ubuntu(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff8C33C1),
                    ),
                  ),
                  subtitle: Text(
                    "Quoted Price: ${pendingQuotesList[index].quotationPrice}",
                    style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8C33C1),
                    ),
                  ),
                  trailing: isPending
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                addTenderBloc.add(AwardQuoteTenderEvent(
                                    quote: pendingQuotesList[index],
                                    accepted: true));
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Accept'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                addTenderBloc.add(AwardQuoteTenderEvent(
                                    quote: pendingQuotesList[index],
                                    accepted: false));
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Decline'),
                            ),
                          ],
                        )
                      : null,
                )),
          );
        },
      ),
    );
  }
}

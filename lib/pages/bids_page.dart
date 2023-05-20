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

class TenderBigsPageState extends State<TenderBigsPage> {
  late AddTenderBloc addTenderBloc;
  List<Quotes> quotesList = [];
  @override
  void initState() {
    super.initState();
    addTenderBloc = BlocProvider.of<AddTenderBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as BidsScreenArgs;
    addTenderBloc.add(FetchQuotesEvent(tenderId: args.tenderId));
    return Scaffold(body: BlocBuilder<AddTenderBloc, AddTenderState>(
      builder: (context, state) {
        if (state is FetchQuotesInProgressState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FetchQuotesSuccessState) {
          quotesList = state.quotesList;
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: quotesList.length,
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
                        quotesList[index].userInfo.name,
                        style: GoogleFonts.ubuntu(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff8C33C1),
                        ),
                      ),
                      subtitle: Text(
                        "Quoted Price: ${quotesList[index].quotationPrice}",
                        style: GoogleFonts.ubuntu(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF8C33C1),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Text("Failed to fetch bids. Please try again later.");
      },
    ));
  }
}

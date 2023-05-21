import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vender/logic/bloc/addQuotationBloc/add_quotation_bloc.dart';
import 'package:vender/models/tender.dart';
import 'package:vender/routes/arguments/screen_args.dart';
import 'package:vender/routes/routes.dart';

class SeeTender extends StatefulWidget {
  const SeeTender({super.key});

  @override
  State<SeeTender> createState() => _SeeTenderState();
}

late AddQuotationBloc addQuotationBloc;

class _SeeTenderState extends State<SeeTender> {
  @override
  void initState() {
    super.initState();
    addQuotationBloc = BlocProvider.of<AddQuotationBloc>(context);
    addQuotationBloc.add(FetchTendersQuotation());
  }

  @override
  Widget build(BuildContext context) {
    List<Tender> currentTenders = [];
    List<Tender> previousTenders = [];
    List<Tender> acceptedTenders = [];

    return Scaffold(body: BlocBuilder<AddQuotationBloc, AddQuotationState>(
        builder: (context, state) {
      if (state is FetchTendersQuotationInProgressState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is FetchTendersQuotationSuccessState) {
        Map<String, List<Tender>> recivevedLists = state.tenderList;
        previousTenders = recivevedLists["previous"]!;
        currentTenders = recivevedLists["current"]!;
        acceptedTenders = recivevedLists["accepted"]!;
      } else if(state is FetchTendersQuotationFailureState){
        return const Text("No Tenders Found");
      }
      return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Tenders',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: const Color(0xff8C33C1),
              ),
            ),
          ),
          currentTenders.isEmpty
              ? Column(
                  children: const [
                    SizedBox(height: 20),
                    Center(child: Text("No Pending Tenders found")),
                    SizedBox(height: 20),
                  ],
                )
              : PreviousQuotations(
                  previousTenders: currentTenders,
                  fromPreviousQuotation: false,
                ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Previous Quotation',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: const Color(0xff8C33C1),
              ),
            ),
          ),
          previousTenders.isEmpty
              ? Column(
                  children: const [
                    SizedBox(height: 20),
                    Center(child: Text("No Previous Quotations found")),
                    SizedBox(height: 20),
                  ],
                )
              : PreviousQuotations(
                  previousTenders: previousTenders,
                  fromPreviousQuotation: true),
                  const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Accepted Quotation',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: const Color(0xff8C33C1),
              ),
            ),
          ),
          acceptedTenders.isEmpty
              ? Column(
                  children: const [
                    SizedBox(height: 20),
                    Center(child: Text("No Accepted Quotations found")),
                    SizedBox(height: 20),
                  ],
                )
              : PreviousQuotations(
                  previousTenders: acceptedTenders,
                  fromPreviousQuotation: true),
          const SizedBox(
            height: 50,
          ),
        ]),
      );
    }));
  }
}

class PreviousQuotations extends StatefulWidget {
  final List<Tender> previousTenders;
  final bool? fromPreviousQuotation;
  const PreviousQuotations({
    Key? key,
    required this.previousTenders,
    required this.fromPreviousQuotation,
  }) : super(key: key);

  @override
  State<PreviousQuotations> createState() => _PreviousQuotationsState();
}

class _PreviousQuotationsState extends State<PreviousQuotations> {
  String? imgUrl;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.previousTenders.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: const Color(0xffe4d3e8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 9,
              child: ListTile(
                trailing: Text(widget.fromPreviousQuotation != null &&
                        widget.fromPreviousQuotation!
                    ? 'Rs. ${widget.previousTenders[index].price.toString()}'
                    : ""),
                onTap: () async {
                  Tender tender = Tender(
                    price: widget.previousTenders[index].price,
                    tenderQuotId: widget.previousTenders[index].tenderQuotId,
                    category: widget.previousTenders[index].category,
                    imgUrl: widget.previousTenders[index].imgUrl,
                    name: widget.previousTenders[index].name,
                    quantity: widget.previousTenders[index].quantity,
                  );
                  if (widget.fromPreviousQuotation == null) {
                    Navigator.pushNamed(context, MyRoutes.bidsRoute,
                        arguments: BidsScreenArgs(
                            tender: widget.previousTenders[index]));
                  } else {
                    await Navigator.pushNamed(context, MyRoutes.quotationRoute,
                        arguments: QuotationScreenArguments(
                            tenderData: tender,
                            fromPreviousQuotation:
                                widget.fromPreviousQuotation));
                                if(!widget.fromPreviousQuotation!){

                    addQuotationBloc.add(FetchTendersQuotation());
                                }
                  }
                },
                leading: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 66,
                    minHeight: 64,
                    maxWidth: 66,
                    maxHeight: 64,
                  ),
                  child: Image.network(
                    widget.previousTenders[index].imgUrl,
                  ),
                ),
                title: Text(
                  widget.previousTenders[index].name,
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff8C33C1),
                  ),
                ),
                subtitle: Text(
                  "Qty: ${widget.previousTenders[index].quantity}\nCategory: ${widget.previousTenders[index].category}",
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
}

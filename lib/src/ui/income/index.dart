import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/incomeController.dart';
import 'package:kasir_app/src/model/income_model.dart';
import 'package:kasir_app/src/ui/components/custom_components.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IncomeUI extends StatefulWidget {
  @override
  State<IncomeUI> createState() => _IncomeUIState();
}

class _IncomeUIState extends State<IncomeUI> {
  final conIncome = Get.put(IncomeController());

  final _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));

    conIncome.isLoading.value = true;
    conIncome.getTransaksi(1);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    conIncome.getTransaksi(conIncome.incomePage.value + 1);
    if (mounted) setState(() {});

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    conIncome.getTransaksi(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: height(context) * 0.01),
          Container(
            width: width(context),
            height: height(context) * 0.04,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Riwayat Pendapatan',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height(context) * 0.02),
          Container(
            height: height(context) * 0.8,
            child: Obx(() {
              final transaksi = conIncome.listIncome.value;

              if (conIncome.isLoading.value) {
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    for (var i = 0; i < 8; i++)
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: CustomShimmer(
                          width: width(context),
                          height: width(context) * 0.2,
                          radius: 10,
                        ),
                      )
                  ],
                );
              }

              if (transaksi.isEmpty) {
                return CustomEmptyData(
                  height: height(context) * 0.9,
                  text: 'Data tidak ditemukan',
                  onPressed: () async {
                    conIncome.isLoading.value = true;
                    conIncome.getTransaksi(1);
                  },
                );
              }

              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () => _onRefresh(),
                onLoading: () => _onLoading(),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    ...transaksi.map((e) => _itemProductList(context, e)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _itemProductList(BuildContext context, IncomeModel item) {
    // intl date
    final date = DateFormat('dd MMMM yyyy')
        .format(DateTime.parse(item.transaction!.date ?? ''));

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item.item!.name ?? '-',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${item.quantity} - ${toRupiah(double.parse(item.item!.price ?? "0"))}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

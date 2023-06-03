// class Gas {
//   String gasName;
//   String image;
//   String size;
//   String currentStock;
//   String mustStock;
//   String minStock;
//   String noHpDist;

//   Gas({
//     required this.gasName,
//     required this.image,
//     required this.size,
//     required this.currentStock,
//     required this.mustStock,
//     required this.minStock,
//     required this.noHpDist,
//   });

//   factory Gas.fromMap(Map<String, dynamic> json) {
//     return Gas(
//         gasName: json["gasName"],
//         image: json["image"],
//         size: json["size"],
//         currentStock: json["currentStock"],
//         mustStock: json["mustStock"],
//         minStock: json["minStock"],
//         noHpDist: json["noHpDist"]);
//   }
// }

// class GasResponse {
//   List<Gas> dataGas;
//   String message;

//   GasResponse({required this.message, required this.dataGas});

//   factory GasResponse.fromMap(Map<String, dynamic> json) {
//     return GasResponse(
//         dataGas:
//             List<Gas>.from((json["data"] as List).map((e) => Gas.fromMap(e))),
//         message: json["message"]);
//   }
// }

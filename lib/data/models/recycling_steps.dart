// class RecyclingStep {
//   final String stepNumber;
//   final String title;
//   final String description;

//   RecyclingStep({
//     required this.stepNumber,
//     required this.title,
//     required this.description,
//   });
// }

// // List of recycling steps
// List<RecyclingStep> recyclingSteps = [
//   RecyclingStep(
//     stepNumber: "1",
//     title: "Collection",
//     description: "E-waste is collected via drop-off centers, recycling bins, and retailer take-back programs.",
//   ),
//   RecyclingStep(
//     stepNumber: "2",
//     title: "Transportation & Sorting",
//     description: "E-waste is transported to facilities and sorted into categories like batteries and circuit boards.",
//   ),
//   RecyclingStep(
//     stepNumber: "3",
//     title: "Dismantling & Component Recovery",
//     description: "Devices are manually dismantled to recover valuable parts such as circuit boards and batteries.",
//   ),
//   RecyclingStep(
//     stepNumber: "4",
//     title: "Shredding & Material Separation",
//     description: "Non-reusable parts are shredded and separated using magnets, air, and water techniques.",
//   ),
//   RecyclingStep(
//     stepNumber: "5",
//     title: "Refining & Recycling",
//     description: "Extracted materials like metals, plastics, and glass are refined and used in new electronics.",
//   ),
// ];
class RecyclingStep {
  final String stepNumber;
  final String title;
  final String description;
  final String? imageUrl;

  RecyclingStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    this.imageUrl,
  });
}


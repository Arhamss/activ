// import 'package:activ/exports.dart';
// import 'package:country_picker/country_picker.dart';

// class CustomCountryDropdown extends StatefulWidget {
//   const CustomCountryDropdown({
//     required this.onCountrySelected,
//     super.key,
//   });

//   final Function(Country) onCountrySelected;

//   @override
//   State<CustomCountryDropdown> createState() => _CustomCountryDropdownState();
// }

// class _CustomCountryDropdownState extends State<CustomCountryDropdown> {
//   late List<Country> countries;
//   late Country selectedCountry;

//   @override
//   void initState() {
//     super.initState();
//     countries = CountryPickerUtils.getAll(); // Get all countries from the `country_picker` package
//     selectedCountry = countries.first; // Default to the first country
//   }

//   void _showCountryPickerDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: SizedBox(
//             height: 400,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Text(
//                     'Select Country',
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: countries.length,
//                     itemBuilder: (context, index) {
//                       final country = countries[index];
//                       return ListTile(
//                         leading: Text(
//                           country.flagEmoji,
//                           style: const TextStyle(fontSize: 24),
//                         ),
//                         title: Text(country.name),
//                         subtitle: Text('+${country.phoneCode}'),
//                         onTap: () {
//                           setState(() {
//                             selectedCountry = country;
//                           });
//                           widget.onCountrySelected(country);
//                           Navigator.of(context).pop();
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _showCountryPickerDialog,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.greyShade6),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Text(
//               selectedCountry.flagEmoji,
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(width: 8),
//             Text(
//               '+${selectedCountry.phoneCode}',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             const Spacer(),
//             const Icon(Icons.arrow_drop_down),
//           ],
//         ),
//       ),
//     );
//   }
// }

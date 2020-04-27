import 'package:google_maps_webservice/places.dart' as prediction;

class Prediction extends prediction.Prediction {
  Prediction(String description, String id, List<prediction.Term> terms, String placeId, String reference, List<String> types,
      List<prediction.MatchedSubstring> matchedSubstrings, prediction.StructuredFormatting structuredFormatting)
      : super(description, id, terms, placeId, reference, types, matchedSubstrings, structuredFormatting);
}

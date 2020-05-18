import 'package:haircut_delivery/model/post_model.dart';
import 'package:haircut_delivery/service/haircut_service_client.dart';

class PostRepository {
  final _client = HaircutServiceClient();

  Future<List<Posts>> fetchMyPostList() async {
    final response = await _client.get('posts', withAccessToken: false);
    print('repo :: $_client');
    return response
        .map<Posts>((post) => Posts.fromJson(post))
        .toList(growable: false);
  }

  Future createMyPlace(CreatePostParameters parameters) async {
    // print(_client.post('posts', data: parameters, withAccessToken: false));
    return await _client.post('posts',
        data: parameters, withAccessToken: false);
  }

  Future updateMyPlace(int id, UpdatePostParameters parameters) async {
    return await _client.put('posts/$id',
        data: parameters, withAccessToken: false);
  }

  Future deleteMyPlace(int id) async {
    return await _client.delete('posts/$id', withAccessToken: false);
  }
}

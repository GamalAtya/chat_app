

enum MsgType{
  photo , text
}

MsgType msgTypeFromJson(String json) {
  switch (json) {
    case 'MsgType.photo':
      return MsgType.photo;
    case 'MsgType.text':
      return MsgType.text;
    default:
      throw Exception('Invalid enum value: $json');
  }
}
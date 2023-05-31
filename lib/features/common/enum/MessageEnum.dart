enum MessageEnum{
  TEXT('TEXT'),
  IMAGE('IMAGE'),
  AUDIO('AUDIO'),
  VIDEO('VIDEO'),
  GIF('GIF');

  const MessageEnum(this.type);
  final String type;
}

extension ConvertMessage on String {
  MessageEnum toEnum(){
    switch(this){
      case 'TEXT':
        return MessageEnum.TEXT;
      case 'IMAGE':
        return MessageEnum.IMAGE;
      case 'AUDIO':
        return MessageEnum.AUDIO;
      case 'VIDEO':
        return MessageEnum.VIDEO;
      case 'GIF':
        return MessageEnum.GIF;
      default:
        return MessageEnum.TEXT;
    }
  }
}
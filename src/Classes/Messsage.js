export class Message {
  constructor(id, content, MyUserID, date, userToID) {
    this.id = id;
    this.content = content;
    this.MyUserID = MyUserID;
    this.date = date;
    this.userToID = userToID;
  }
}




let msg = new Message("", "", "", "", "");

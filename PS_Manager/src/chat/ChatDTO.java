package chat;

public class ChatDTO {
	private String chatID;
	public ChatDTO(String chatID, String chatName, String chatContent, String chatTime) {
		super();
		this.chatID = chatID;
		this.chatName = chatName;
		this.chatContent = chatContent;
		this.chatTime = chatTime;
	}
	public String getChatID() {
		return chatID;
	}
	public void setChatID(String chatID) {
		this.chatID = chatID;
	}
	private String chatName;
	private String chatContent;
	private String chatTime;
	public String getChatName() {
		return chatName;
	}
	public void setChatName(String chatName) {
		this.chatName = chatName;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatTime() {
		return chatTime;
	}
	public void setChatTime(String chatTime) {
		this.chatTime = chatTime;
	}
	public ChatDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
}

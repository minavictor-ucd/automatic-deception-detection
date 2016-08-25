package ie.ucd.mscba.add.cues;

public class CueValue {
	public CueValue(CueValueType type, Object value) {
		this.type = type;
		this.value = value;
	}
	
	public CueValue() {
		this(CueValueType.Unknown, new Object());
	}

	public CueValueType getType() {
		return type;
	}

	public void setType(CueValueType type) {
		this.type = type;
	}

	public Object getValue() {
		return value;
	}

	public void setValue(Object value) {
		this.value = value;
	}

	public static CueValue Default = new CueValue();
	
	private CueValueType type;
	private Object value;
}

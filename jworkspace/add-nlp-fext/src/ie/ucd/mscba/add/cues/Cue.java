package ie.ucd.mscba.add.cues;

public abstract class Cue {
	public Cue(String name, String friendlyName, String description) {
		super();
		this.name = name;
		this.friendlyName = friendlyName;
		this.description = description;
		this.value = CueValue.Default;
	}

	public abstract CueValue calculate(String textObservation);

	public String getName() {
		return name;
	}

	public String getFriendlyName() {
		return friendlyName;
	}

	public String getDescription() {
		return description;
	}

	public CueValue getValue() {
		return value;
	}

	public void setValue(CueValue value) {
		this.value = value;
	}
	
	private String name;
	private String friendlyName;
	private String description;
	private CueValue value;
}

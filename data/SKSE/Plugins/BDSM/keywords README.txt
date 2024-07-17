keywords are BDSMs main way of detecting restraints and their effects
some keywords have hardcoded effects, these are mentioned in the "info" property

BDSM parses all armors on game launch and checks for any of these keywords
if a keyword is found on an item BDSM will dynamically add all keywords it inherits to the armor (recursively), too
in addition it will also always add the bdsmNoStrip keyword, which makes it a reliable identifier for any kind of restraint

field summary:

"info" (string): does not get parsed and is only there for documentational purposes
"keyword" (object): the keyword form associated with these properties
"inherits" (list<string>): a list of keywords that are included in this keyword
	this must be the name of the associated json file, not the editor ID

form fields:
"mod" (string): the name of the mod this form is defined in, including the file extension
"formid" (string): the form id of the form in hexadecimal notation
	note: json doesn't support hexadecimal notation, which is why this is a string and not an int
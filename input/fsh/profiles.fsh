// @Name: Complex Extensions
// @Description: Examples of extensions with sub-extensions. Note that an extension cannot have BOTH a value and extensions.

Extension: RelatedLocation
Id: related-location
Title: "Complex Location Extension"
Description: "A complex extension for the Location resource containing relationshipType and relatedResource."
* insert ExtensionContext(Location)

* extension contains
    relationshipType 0..1 MS and
    relatedResource 0..1 MS

* extension[relatedResource].value[x] only Reference
* extension[relationshipType].value[x] only Coding
* extension[relationshipType].valueCoding from VSRelationships (required)
* extension[relationshipType].valueCoding.binding



* insert DocumentExtension (
    relationshipType,
    "relationship type",
    "A BodyStructure resource representing the body structure treated\, for example\, Chest Wall Lymph Nodes.")
* insert DocumentExtension (
    relatedResource, 
    "Related Resource",
    "The total amount of radiation delivered to this volume within the scope of this dose delivery.")



// This rule set limits the application of an extension to the given path
RuleSet: ExtensionContext(path)
* ^context[+].type = #element
* ^context[=].expression = "{path}"

// The strings defined for short and definition should not be quoted, and any comma must be escaped with a backslash.
RuleSet: DocumentExtension(path, short, definition)
* extension[{path}] ^short = {short}
* extension[{path}] ^definition = {definition}




// Define the value set for relationship types
ValueSet: VSRelationships
Id: vs-relationships
Title: "Relationship Types"
Description: "A value set for relationship types."
// Compose:
//   include:
//     system: http://example.org/fhir/CodeSystem/relationship-types
//     concept:
//       - code: sibling
//         display: "Sibling"
//       - code: parent
//         display: "Parent"
//       - code: child
//         display: "Child"

// Define the profile for Location
Profile: LocationWithComplexExtension
Parent: Location
Id: location-with-complex-extension
Title: "Location with Complex Extension"
Description: "Profile for Location resource with multiple complex extensions containing relationshipType and relatedResource."

* extension contains RelatedLocation named relatedLocation 0..*



Instance: SP-related-location-type
InstanceOf: SearchParameter
Usage: #definition
Title: "related-location-type"
* name = "related-location-type"
* status = #active
* experimental = false
* description = "Search on related location type"
* code = #related-location-type
* base = #Bundle
* type = #token
* expression = "Location.extension.where(url='http://example.com/fhir/example/StructureDefinition/related-location').extension.where(url='relationshipType').valueCoding"




Instance: Country1
InstanceOf: LocationWithComplexExtension
Usage: #definition
Title: "Country 1"
* name = "Country 1"

Instance: Province1
InstanceOf: LocationWithComplexExtension
Usage: #definition
Title: "Province 1"
* name = "Province 1"
* extension[relatedLocation]
  //* extension[relatedResource].valueReference = Reference(Country1)

  * extension[relationshipType].valueCoding = #partof
  * extension[relatedResource].valueReference = Reference(Country1)

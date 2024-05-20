Logical: LocationGraphNode
Title: "Location Graph Node - model"
Description: "Logical model for location graph node"
Characteristics: #can-be-target

* identifier 0..1 II "Identifier for the location"
* relatedLocation 0..* BackboneElement "related locatoins"
  * relationship 1..1 CodeableConcept
  * relatedLocation 1..1 Reference

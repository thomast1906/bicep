
// wrong declaration
bad
//@[0:3) [BCP007 (Error)] This declaration type is not recognized. Specify a parameter, variable, resource, or output declaration. |bad|

// incomplete #completionTest(9) -> empty
resource 
//@[9:9) [BCP017 (Error)] Expected a resource identifier at this location. ||
//@[9:9) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". ||
resource foo
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[12:12) [BCP068 (Error)] Expected a resource type string. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". ||
//@[12:12) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". ||
resource fo/o
//@[11:12) [BCP068 (Error)] Expected a resource type string. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". |/|
//@[11:13) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". |/o|
//@[13:13) [BCP018 (Error)] Expected the "=" character at this location. ||
resource foo 'ddd'
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:18) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". |'ddd'|
//@[18:18) [BCP018 (Error)] Expected the "=" character at this location. ||

// #completionTest(23) -> resourceTypes
resource trailingSpace  
//@[24:24) [BCP068 (Error)] Expected a resource type string. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". ||
//@[24:24) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". ||

// #completionTest(19,20) -> object
resource foo 'ddd'= 
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:18) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". |'ddd'|
//@[20:20) [BCP118 (Error)] Expected the "{" character, the "[" character, or the "if" keyword at this location. ||

// wrong resource type
resource foo 'ddd'={
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:18) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". |'ddd'|
}

resource foo 'ddd'=if (1 + 1 == 2) {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:18) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". |'ddd'|
}

// using string interpolation for the resource type
resource foo 'Microsoft.${provider}/foos@2020-02-02-alpha'= {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:58) [BCP047 (Error)] String interpolation is unsupported for specifying the resource type. |'Microsoft.${provider}/foos@2020-02-02-alpha'|
}

resource foo 'Microsoft.${provider}/foos@2020-02-02-alpha'= if (true) {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:58) [BCP047 (Error)] String interpolation is unsupported for specifying the resource type. |'Microsoft.${provider}/foos@2020-02-02-alpha'|
}

// missing required property
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'={
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[9:12) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "name". |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
}

resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if (name == 'value') {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[9:12) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "name". |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[56:60) [BCP057 (Error)] The name "name" does not exist in the current context. |name|
}

resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if ({ 'a': b }.a == 'foo') {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[63:64) [BCP057 (Error)] The name "b" does not exist in the current context. |b|
//@[65:66) [BCP019 (Error)] Expected a new line character at this location. |}|
}
//@[1:1) [BCP018 (Error)] Expected the ")" character at this location. ||

// simulate typing if condition
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[54:54) [BCP018 (Error)] Expected the "(" character at this location. ||

resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if (
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[56:56) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. ||

resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if (true
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[60:60) [BCP018 (Error)] Expected the ")" character at this location. ||

resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if (true)
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[61:61) [BCP018 (Error)] Expected the "{" character at this location. ||

// missing condition
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[55:56) [BCP018 (Error)] Expected the "(" character at this location. |{|
  name: 'foo'
//@[8:13) [BCP121 (Error)] Resources: "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo" are defined with this same name in a file. Rename them or split into different modules. |'foo'|
}

// empty condition
// #completionTest(56) -> symbols
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if () {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[56:57) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. |)|
  name: 'foo'
//@[8:13) [BCP121 (Error)] Resources: "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo" are defined with this same name in a file. Rename them or split into different modules. |'foo'|
}

// #completionTest(57, 59) -> symbols
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if (     ) {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[61:62) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. |)|
  name: 'foo'
//@[8:13) [BCP121 (Error)] Resources: "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo" are defined with this same name in a file. Rename them or split into different modules. |'foo'|
}

// invalid condition type
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= if (123) {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[55:60) [BCP046 (Error)] Expected a value of type "bool". |(123)|
  name: 'foo'
//@[8:13) [BCP121 (Error)] Resources: "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo" are defined with this same name in a file. Rename them or split into different modules. |'foo'|
}

// runtime functions are no allowed in resource conditions
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha' = if (reference('Micorosft.Management/managementGroups/MG', '2020-05-01').name == 'something') {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[57:66) [BCP066 (Error)] Function "reference" is not valid at this location. It can only be used in resource declarations. |reference|
  name: 'foo'
//@[8:13) [BCP121 (Error)] Resources: "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo" are defined with this same name in a file. Rename them or split into different modules. |'foo'|
}

resource foo 'Microsoft.Foo/foos@2020-02-02-alpha' = if (listKeys('foo', '2020-05-01').bar == true) {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
//@[57:65) [BCP066 (Error)] Function "listKeys" is not valid at this location. It can only be used in resource declarations. |listKeys|
  name: 'foo'
//@[8:13) [BCP121 (Error)] Resources: "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo" are defined with this same name in a file. Rename them or split into different modules. |'foo'|
}

// duplicate property at the top level
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'foo'
//@[2:6) [BCP025 (Error)] The property "name" is declared multiple times in this object. Remove or rename the duplicate properties. |name|
  name: true
//@[2:6) [BCP025 (Error)] The property "name" is declared multiple times in this object. Remove or rename the duplicate properties. |name|
}

// duplicate property at the top level with string literal syntax
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'foo'
//@[2:6) [BCP025 (Error)] The property "name" is declared multiple times in this object. Remove or rename the duplicate properties. |name|
  'name': true
//@[2:8) [BCP025 (Error)] The property "name" is declared multiple times in this object. Remove or rename the duplicate properties. |'name'|
}

// duplicate property inside
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'foo'
//@[8:13) [BCP121 (Error)] Resources: "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo" are defined with this same name in a file. Rename them or split into different modules. |'foo'|
  properties: {
    foo: 'a'
//@[4:7) [BCP025 (Error)] The property "foo" is declared multiple times in this object. Remove or rename the duplicate properties. |foo|
    foo: 'a'
//@[4:7) [BCP025 (Error)] The property "foo" is declared multiple times in this object. Remove or rename the duplicate properties. |foo|
  }
}

// duplicate property inside with string literal syntax
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'foo'
//@[8:13) [BCP121 (Error)] Resources: "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo" are defined with this same name in a file. Rename them or split into different modules. |'foo'|
  properties: {
    foo: 'a'
//@[4:7) [BCP025 (Error)] The property "foo" is declared multiple times in this object. Remove or rename the duplicate properties. |foo|
    'foo': 'a'
//@[4:9) [BCP025 (Error)] The property "foo" is declared multiple times in this object. Remove or rename the duplicate properties. |'foo'|
  }
}

// wrong property types
resource foo 'Microsoft.Foo/foos@2020-02-02-alpha'= {
//@[9:12) [BCP028 (Error)] Identifier "foo" is declared multiple times. Remove or rename the duplicates. |foo|
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'foo'
//@[8:13) [BCP121 (Error)] Resources: "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo", "foo" are defined with this same name in a file. Rename them or split into different modules. |'foo'|
  location: [
//@[12:18) [BCP036 (Error)] The property "location" expected a value of type "string" but the provided value is of type "array". |[\r\n  ]|
  ]
  tags: 'tag are not a string?'
//@[8:31) [BCP036 (Error)] The property "tags" expected a value of type "Tags" but the provided value is of type "'tag are not a string?'". |'tag are not a string?'|
}

resource bar 'Microsoft.Foo/foos@2020-02-02-alpha' = {
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: true ? 's' : 'a' + 1
//@[21:28) [BCP045 (Error)] Cannot apply operator "+" to operands of type "'a'" and "int". |'a' + 1|
  properties: {
    x: foo()
//@[7:10) [BCP059 (Error)] The name "foo" is not a function. |foo|
    y: true && (null || !4)
//@[24:26) [BCP044 (Error)] Cannot apply operator "!" to operand of type "int". |!4|
    a: [
      a
//@[6:7) [BCP057 (Error)] The name "a" does not exist in the current context. |a|
      !null
//@[6:11) [BCP044 (Error)] Cannot apply operator "!" to operand of type "null". |!null|
      true && true || true + -true * 4
//@[29:34) [BCP044 (Error)] Cannot apply operator "-" to operand of type "bool". |-true|
    ]
  }
}

// unsupported resource ref
var resrefvar = bar.name

param resrefpar string = foo.id
//@[25:28) [BCP072 (Error)] This symbol cannot be referenced here. Only other parameters can be referenced in parameter default values. |foo|
//@[25:28) [BCP062 (Error)] The referenced declaration with name "foo" is not valid. |foo|

output resrefout bool = bar.id
//@[24:30) [BCP026 (Error)] The output expects a value of type "bool" but the provided value is of type "string". |bar.id|

// attempting to set read-only properties
resource baz 'Microsoft.Foo/foos@2020-02-02-alpha' = {
//@[13:50) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'test'
//@[8:14) [BCP121 (Error)] Resources: "baz", "badDepends", "badDepends2", "badDepends3", "badDepends4", "badDepends5", "badInterp" are defined with this same name in a file. Rename them or split into different modules. |'test'|
  id: 2
//@[2:4) [BCP073 (Error)] The property "id" is read-only. Expressions cannot be assigned to read-only properties. |id|
  type: 'hello'
//@[2:6) [BCP073 (Error)] The property "type" is read-only. Expressions cannot be assigned to read-only properties. |type|
  apiVersion: true
//@[2:12) [BCP073 (Error)] The property "apiVersion" is read-only. Expressions cannot be assigned to read-only properties. |apiVersion|
}

resource badDepends 'Microsoft.Foo/foos@2020-02-02-alpha' = {
//@[20:57) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'test'
//@[8:14) [BCP121 (Error)] Resources: "baz", "badDepends", "badDepends2", "badDepends3", "badDepends4", "badDepends5", "badInterp" are defined with this same name in a file. Rename them or split into different modules. |'test'|
  dependsOn: [
    baz.id
//@[4:10) [BCP034 (Error)] The enclosing array expected an item of type "resource | module", but the provided item was of type "string". |baz.id|
  ]
}

resource badDepends2 'Microsoft.Foo/foos@2020-02-02-alpha' = {
//@[21:58) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'test'
//@[8:14) [BCP121 (Error)] Resources: "baz", "badDepends", "badDepends2", "badDepends3", "badDepends4", "badDepends5", "badInterp" are defined with this same name in a file. Rename them or split into different modules. |'test'|
  dependsOn: [
    'hello'
//@[4:11) [BCP034 (Error)] The enclosing array expected an item of type "resource | module", but the provided item was of type "'hello'". |'hello'|
    true
//@[4:8) [BCP034 (Error)] The enclosing array expected an item of type "resource | module", but the provided item was of type "bool". |true|
  ]
}

resource badDepends3 'Microsoft.Foo/foos@2020-02-02-alpha' = {
//@[21:58) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'test'
//@[8:14) [BCP121 (Error)] Resources: "baz", "badDepends", "badDepends2", "badDepends3", "badDepends4", "badDepends5", "badInterp" are defined with this same name in a file. Rename them or split into different modules. |'test'|
}

resource badDepends4 'Microsoft.Foo/foos@2020-02-02-alpha' = {
//@[21:58) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'test'
//@[8:14) [BCP121 (Error)] Resources: "baz", "badDepends", "badDepends2", "badDepends3", "badDepends4", "badDepends5", "badInterp" are defined with this same name in a file. Rename them or split into different modules. |'test'|
  dependsOn: [
    badDepends3
  ]
}

resource badDepends5 'Microsoft.Foo/foos@2020-02-02-alpha' = {
//@[21:58) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'test'
//@[8:14) [BCP121 (Error)] Resources: "baz", "badDepends", "badDepends2", "badDepends3", "badDepends4", "badDepends5", "badInterp" are defined with this same name in a file. Rename them or split into different modules. |'test'|
  dependsOn: badDepends3.dependsOn
//@[25:34) [BCP077 (Error)] The property "dependsOn" on type "Microsoft.Foo/foos@2020-02-02-alpha" is write-only. Write-only properties cannot be accessed. |dependsOn|
}

var interpVal = 'abc'
resource badInterp 'Microsoft.Foo/foos@2020-02-02-alpha' = {
//@[19:56) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'test'
//@[8:14) [BCP121 (Error)] Resources: "baz", "badDepends", "badDepends2", "badDepends3", "badDepends4", "badDepends5", "badInterp" are defined with this same name in a file. Rename them or split into different modules. |'test'|
  '${interpVal}': 'unsupported' // resource definition does not allow for additionalProperties
  '${undefinedSymbol}': true
//@[5:20) [BCP057 (Error)] The name "undefinedSymbol" does not exist in the current context. |undefinedSymbol|
}

module validModule './module.bicep' = {
  name: 'storageDeploy'
  params: {
    name: 'contoso'
  }
}

resource runtimeValidRes1 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: 'name1'
  location: 'eastus'
  properties: {
    evictionPolicy: 'Deallocate'
  }
}

resource runtimeValidRes2 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: concat(concat(runtimeValidRes1.id, runtimeValidRes1.name), runtimeValidRes1.type)
  kind:'AzureCLI'
  location: 'eastus'
  properties: {
    azCliVersion: '2.0'
    retentionInterval: runtimeValidRes1.properties.evictionPolicy
  }
}

resource runtimeValidRes3 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: '${runtimeValidRes1.name}_v1'
}

resource runtimeValidRes4 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: concat(validModule['name'], 'v1')
}

resource runtimeValidRes5 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: '${validModule.name}_v1'
}

resource runtimeInvalidRes1 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValidRes1.location
//@[8:33) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeValidRes1.location|
}

resource runtimeInvalidRes2 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValidRes1['location']
//@[8:36) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeValidRes1['location']|
}

resource runtimeInvalidRes3 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: runtimeValidRes1.properties.evictionPolicy
//@[8:50) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeValidRes1.properties.evictionPolicy|
  kind:'AzureCLI'
  location: 'eastus'
  properties: {
    azCliVersion: '2.0'
    retentionInterval: runtimeValidRes1.properties.evictionPolicy
  }
}

resource runtimeInvalidRes4 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValidRes1['properties'].evictionPolicy
//@[8:53) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeValidRes1['properties'].evictionPolicy|
}

resource runtimeInvalidRes5 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValidRes1['properties']['evictionPolicy']
//@[8:56) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeValidRes1['properties']['evictionPolicy']|
}

resource runtimeInvalidRes6 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValidRes1.properties['evictionPolicy']
//@[8:53) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeValidRes1.properties['evictionPolicy']|
}

resource runtimeInvalidRes7 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValidRes2.properties.azCliVersion
//@[8:48) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes2 are "apiVersion", "id", "name", "type". |runtimeValidRes2.properties.azCliVersion|
}

var magicString1 = 'location'
resource runtimeInvalidRes8 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValidRes2['${magicString1}']
//@[8:43) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes2 are "apiVersion", "id", "name", "type". |runtimeValidRes2['${magicString1}']|
}

// note: this should be fine, but we block string interpolation all together if there's a potential runtime property usage for name.
var magicString2 = 'name'
resource runtimeInvalidRes9 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValidRes2['${magicString2}']
//@[8:43) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes2 are "apiVersion", "id", "name", "type". |runtimeValidRes2['${magicString2}']|
}

resource runtimeInvalidRes10 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: '${runtimeValidRes3.location}'
//@[28:36) [BCP053 (Error)] The type "Microsoft.Advisor/recommendations/suppressions" does not contain property "location". Available properties include "apiVersion", "id", "name", "properties", "type". |location|
}

resource runtimeInvalidRes11 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: validModule.params['name']
//@[8:34) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of validModule are "name". |validModule.params['name']|
//@[20:26) [BCP077 (Error)] The property "params" on type "module" is write-only. Write-only properties cannot be accessed. |params|
}

resource runtimeInvalidRes12 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: concat(runtimeValidRes1.location, runtimeValidRes2['location'], runtimeInvalidRes3['properties'].azCliVersion, validModule.params.name)
//@[15:40) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeValidRes1.location|
//@[42:70) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes2 are "apiVersion", "id", "name", "type". |runtimeValidRes2['location']|
//@[72:117) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeInvalidRes3 are "apiVersion", "id", "name", "type". |runtimeInvalidRes3['properties'].azCliVersion|
//@[119:142) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of validModule are "name". |validModule.params.name|
//@[131:137) [BCP077 (Error)] The property "params" on type "module" is write-only. Write-only properties cannot be accessed. |params|
}

resource runtimeInvalidRes13 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: '${runtimeValidRes1.location}${runtimeValidRes2['location']}${runtimeInvalidRes3.properties['azCliVersion']}${validModule['params'].name}'
//@[11:36) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeValidRes1.location|
//@[39:67) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes2 are "apiVersion", "id", "name", "type". |runtimeValidRes2['location']|
//@[70:115) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeInvalidRes3 are "apiVersion", "id", "name", "type". |runtimeInvalidRes3.properties['azCliVersion']|
//@[118:144) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of validModule are "name". |validModule['params'].name|
//@[130:138) [BCP077 (Error)] The property "params" on type "module" is write-only. Write-only properties cannot be accessed. |'params'|
}

// variable related runtime validation
var runtimefoo1 = runtimeValidRes1['location']
var runtimefoo2 = runtimeValidRes2['properties'].azCliVersion
var runtimefoo3 = runtimeValidRes2
var runtimefoo4 = {
  hop: runtimefoo2
}

var runtimeInvalid = {
  foo1: runtimefoo1
  foo2: runtimefoo2
  foo3: runtimefoo3
  foo4: runtimeValidRes1.name
}

var runtimeValid = {
  foo1: runtimeValidRes1.name
  foo2: runtimeValidRes1.apiVersion
  foo3: runtimeValidRes2.type
  foo4: runtimeValidRes2.id
}

resource runtimeInvalidRes14 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeInvalid.foo1
//@[8:27) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. You are referencing a variable which cannot be calculated in time ("runtimeInvalid" -> "runtimefoo1" -> "runtimeValidRes1"). Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeInvalid.foo1|
}

resource runtimeInvalidRes15 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeInvalid.foo2
//@[8:27) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. You are referencing a variable which cannot be calculated in time ("runtimeInvalid" -> "runtimefoo1" -> "runtimeValidRes1"). Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeInvalid.foo2|
}

resource runtimeInvalidRes16 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeInvalid.foo3.properties.azCliVersion
//@[8:51) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. You are referencing a variable which cannot be calculated in time ("runtimeInvalid" -> "runtimefoo1" -> "runtimeValidRes1"). Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeInvalid.foo3.properties.azCliVersion|
}

// Note: This is actually a runtime valid value. However, other properties of the variable cannot be resolved, so we block this.
resource runtimeInvalidRes17 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeInvalid.foo4
//@[8:27) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. You are referencing a variable which cannot be calculated in time ("runtimeInvalid" -> "runtimefoo1" -> "runtimeValidRes1"). Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeInvalid.foo4|
}

resource runtimeInvalidRes18 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: concat(runtimeInvalid.foo1, runtimeValidRes2['properties'].azCliVersion, '${runtimeValidRes1.location}', runtimefoo4.hop)
//@[15:34) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. You are referencing a variable which cannot be calculated in time ("runtimeInvalid" -> "runtimefoo1" -> "runtimeValidRes1"). Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeInvalid.foo1|
//@[36:79) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes2 are "apiVersion", "id", "name", "type". |runtimeValidRes2['properties'].azCliVersion|
//@[84:109) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. Accessible properties of runtimeValidRes1 are "apiVersion", "id", "name", "type". |runtimeValidRes1.location|
//@[113:128) [BCP120 (Error)] The property "name" must be evaluable at the start of the deployment, and cannot depend on any values that have not yet been calculated. You are referencing a variable which cannot be calculated in time ("runtimefoo4" -> "runtimefoo2" -> "runtimeValidRes2"). Accessible properties of runtimeValidRes2 are "apiVersion", "id", "name", "type". |runtimefoo4.hop|
}

resource runtimeValidRes6 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValid.foo1
}

resource runtimeValidRes7 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValid.foo2
}

resource runtimeValidRes8 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValid.foo3
}

resource runtimeValidRes9 'Microsoft.Advisor/recommendations/suppressions@2020-01-01' = {
  name: runtimeValid.foo4
}

resource missingTopLevelProperties 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
//@[9:34) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "kind", "location", "name", "sku". |missingTopLevelProperties|
  // #completionTest(0, 1, 2) -> topLevelProperties

}

resource missingTopLevelPropertiesExceptName 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
//@[9:44) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "kind", "location", "sku". |missingTopLevelPropertiesExceptName|
  // #completionTest(0, 1, 2) -> topLevelPropertiesMinusName
  name: 'me'
  // do not remove whitespace before the closing curly
  // #completionTest(0, 1, 2) -> topLevelPropertiesMinusName
  
}

// #completionTest(24,25,26,49,65) -> resourceTypes
resource unfinishedVnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: 'v'
  location: 'eastus'
  properties: {
    subnets: [
      {
        // #completionTest(0,1,2,3,4,5,6,7) -> subnetPropertiesMinusProperties
        properties: {
          delegations: [
            {
              // #completionTest(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14) -> delegationProperties
              
            }
          ]
        }
      }
    ]
  }
}

resource discriminatorKeyMissing 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
//@[86:148) [BCP078 (Error)] The property "kind" requires a value of type "'AzureCLI' | 'AzurePowerShell'", but none was supplied. |{\r\n  // #completionTest(0,1,2) -> discriminatorProperty\r\n  \r\n}|
  // #completionTest(0,1,2) -> discriminatorProperty
  
}

resource discriminatorKeyValueMissing 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  // #completionTest(7,8,9,10) -> deploymentScriptKindsPlusSymbols
  kind:   
//@[10:10) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. ||
}
// #completionTest(76) -> missingDiscriminatorPropertyAccess
var discriminatorKeyValueMissingCompletions = discriminatorKeyValueMissing.p
// #completionTest(76) -> missingDiscriminatorPropertyAccess
var discriminatorKeyValueMissingCompletions2 = discriminatorKeyValueMissing.
//@[76:76) [BCP020 (Error)] Expected a function or property name at this location. ||

// #completionTest(76) -> missingDiscriminatorPropertyIndexPlusSymbols
var discriminatorKeyValueMissingCompletions3 = discriminatorKeyValueMissing[]
//@[76:76) [BCP117 (Error)] An empty indexer is not allowed. Specify a valid expression. ||

resource discriminatorKeySetOne 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
//@[9:31) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "location", "name". |discriminatorKeySetOne|
  kind: 'AzureCLI'
  // #completionTest(0,1,2) -> deploymentScriptTopLevel

  properties: {
//@[2:12) [BCP035 (Warning)] The specified "object" declaration is missing the following required properties: "azCliVersion", "retentionInterval". |properties|
    // #completionTest(0,1,2,3,4) -> deploymentScriptCliProperties
    
  }
}
// #completionTest(75) -> cliPropertyAccess
var discriminatorKeySetOneCompletions = discriminatorKeySetOne.properties.a
//@[74:75) [BCP053 (Warning)] The type "AzureCliScriptProperties" does not contain property "a". Available properties include "arguments", "azCliVersion", "cleanupPreference", "containerSettings", "environmentVariables", "forceUpdateTag", "outputs", "primaryScriptUri", "provisioningState", "retentionInterval", "scriptContent", "status", "storageAccountSettings", "supportingScriptUris", "timeout". |a|
// #completionTest(75) -> cliPropertyAccess
var discriminatorKeySetOneCompletions2 = discriminatorKeySetOne.properties.
//@[75:75) [BCP020 (Error)] Expected a function or property name at this location. ||

// #completionTest(75) -> cliPropertyAccessIndexesPlusSymbols
var discriminatorKeySetOneCompletions3 = discriminatorKeySetOne.properties[]
//@[75:75) [BCP117 (Error)] An empty indexer is not allowed. Specify a valid expression. ||

resource discriminatorKeySetTwo 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
//@[9:31) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "location", "name". |discriminatorKeySetTwo|
  kind: 'AzurePowerShell'
  // #completionTest(0,1,2) -> deploymentScriptTopLevel

  properties: {
//@[2:12) [BCP035 (Warning)] The specified "object" declaration is missing the following required properties: "azPowerShellVersion", "retentionInterval". |properties|
    // #completionTest(0,1,2,3,4) -> deploymentScriptPSProperties
    
  }
}
// #completionTest(75) -> powershellPropertyAccess
var discriminatorKeySetTwoCompletions = discriminatorKeySetTwo.properties.a
//@[74:75) [BCP053 (Warning)] The type "AzurePowerShellScriptProperties" does not contain property "a". Available properties include "arguments", "azPowerShellVersion", "cleanupPreference", "containerSettings", "environmentVariables", "forceUpdateTag", "outputs", "primaryScriptUri", "provisioningState", "retentionInterval", "scriptContent", "status", "storageAccountSettings", "supportingScriptUris", "timeout". |a|
// #completionTest(75) -> powershellPropertyAccess
var discriminatorKeySetTwoCompletions2 = discriminatorKeySetTwo.properties.
//@[75:75) [BCP020 (Error)] Expected a function or property name at this location. ||

// #completionTest(90) -> powershellPropertyAccess
var discriminatorKeySetTwoCompletionsArrayIndexer = discriminatorKeySetTwo['properties'].a
//@[89:90) [BCP053 (Warning)] The type "AzurePowerShellScriptProperties" does not contain property "a". Available properties include "arguments", "azPowerShellVersion", "cleanupPreference", "containerSettings", "environmentVariables", "forceUpdateTag", "outputs", "primaryScriptUri", "provisioningState", "retentionInterval", "scriptContent", "status", "storageAccountSettings", "supportingScriptUris", "timeout". |a|
// #completionTest(90) -> powershellPropertyAccess
var discriminatorKeySetTwoCompletionsArrayIndexer2 = discriminatorKeySetTwo['properties'].
//@[90:90) [BCP020 (Error)] Expected a function or property name at this location. ||

resource incorrectPropertiesKey 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
//@[9:31) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "location", "name", "properties". |incorrectPropertiesKey|
  kind: 'AzureCLI'

  propertes: {
//@[2:11) [BCP089 (Error)] The property "propertes" is not allowed on objects of type "AzureCLI". Did you mean "properties"? |propertes|
  }
}

var mock = incorrectPropertiesKey.p
//@[34:35) [BCP053 (Error)] The type "AzureCLI" does not contain property "p". Available properties include "apiVersion", "id", "identity", "kind", "location", "name", "properties", "systemData", "tags", "type". |p|

resource incorrectPropertiesKey2 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  kind: 'AzureCLI'
  name: 'test'
  location: ''
  properties: {
    azCliVersion: '2'
    retentionInterval: 'PT1H'
    
    // #completionTest(0,1,2,3,4) -> deploymentScriptCliPropertiesMinusSpecified
    
    // #completionTest(22,23) -> cleanupPreferencesPlusSymbols
    cleanupPreference: 
//@[23:23) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. ||

    // #completionTest(25,26) -> arrayPlusSymbols
    supportingScriptUris: 
//@[26:26) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. ||

    // #completionTest(27,28) -> objectPlusSymbols
    storageAccountSettings: 
//@[28:28) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. ||

    environmentVariables: [
      {
        // #completionTest(0,2,4,6,8) -> environmentVariableProperties
        
      }
      // #completionTest(0,1,2,3,4,5,6) -> objectPlusSymbols
      
    ]
  }
}

// #completionTest(21) -> resourceTypes
resource missingType 
//@[21:21) [BCP068 (Error)] Expected a resource type string. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". ||
//@[21:21) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". ||

// #completionTest(37,38,39,40,41,42,43,44) -> resourceTypes
resource startedTypingTypeWithQuotes 'virma'
//@[37:44) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". |'virma'|
//@[44:44) [BCP018 (Error)] Expected the "=" character at this location. ||

// #completionTest(40,41,42,43,44,45) -> resourceTypes
resource startedTypingTypeWithoutQuotes virma
//@[40:45) [BCP068 (Error)] Expected a resource type string. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". |virma|
//@[40:45) [BCP029 (Error)] The resource type is not valid. Specify a valid resource type of format "<provider>/<types>@<apiVersion>". |virma|
//@[45:45) [BCP018 (Error)] Expected the "=" character at this location. ||

resource dashesInPropertyNames 'Microsoft.ContainerService/managedClusters@2020-09-01' = {
//@[9:30) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "location", "name". |dashesInPropertyNames|
}
// #completionTest(78) -> autoScalerPropertiesRequireEscaping
var letsAccessTheDashes = dashesInPropertyNames.properties.autoScalerProfile.s
//@[77:78) [BCP053 (Warning)] The type "schemas:30_autoScalerProfile" does not contain property "s". Available properties include "balance-similar-node-groups", "expander", "max-empty-bulk-delete", "max-graceful-termination-sec", "max-total-unready-percentage", "new-pod-scale-up-delay", "ok-total-unready-count", "scale-down-delay-after-add", "scale-down-delay-after-delete", "scale-down-delay-after-failure", "scale-down-unneeded-time", "scale-down-unready-time", "scale-down-utilization-threshold", "scan-interval", "skip-nodes-with-local-storage", "skip-nodes-with-system-pods". |s|
// #completionTest(78) -> autoScalerPropertiesRequireEscaping
var letsAccessTheDashes2 = dashesInPropertyNames.properties.autoScalerProfile.
//@[78:78) [BCP020 (Error)] Expected a function or property name at this location. ||

resource nestedDiscriminatorMissingKey 'Microsoft.DocumentDB/databaseAccounts@2020-06-01-preview' = {
  name: 'test'
//@[8:14) [BCP121 (Error)] Resources: "nestedDiscriminatorMissingKey", "nestedDiscriminator" are defined with this same name in a file. Rename them or split into different modules. |'test'|
  location: 'l'
  properties: {
//@[14:51) [BCP078 (Warning)] The property "createMode" requires a value of type "'Default' | 'Restore'", but none was supplied. |{\r\n    //createMode: 'Default'\r\n\r\n  }|
    //createMode: 'Default'

  }
}
// #completionTest(90) -> createMode
var nestedDiscriminatorMissingKeyCompletions = nestedDiscriminatorMissingKey.properties.cr
// #completionTest(92) -> createMode
var nestedDiscriminatorMissingKeyCompletions2 = nestedDiscriminatorMissingKey['properties'].
//@[92:92) [BCP020 (Error)] Expected a function or property name at this location. ||

// #completionTest(94) -> createModeIndexPlusSymbols
var nestedDiscriminatorMissingKeyIndexCompletions = nestedDiscriminatorMissingKey.properties['']

resource nestedDiscriminator 'Microsoft.DocumentDB/databaseAccounts@2020-06-01-preview' = {
  name: 'test'
//@[8:14) [BCP121 (Error)] Resources: "nestedDiscriminatorMissingKey", "nestedDiscriminator" are defined with this same name in a file. Rename them or split into different modules. |'test'|
  location: 'l'
  properties: {
//@[2:12) [BCP035 (Warning)] The specified "object" declaration is missing the following required properties: "databaseAccountOfferType", "locations". |properties|
    createMode: 'Default'

  }
}
// #completionTest(69) -> defaultCreateModeProperties
var nestedDiscriminatorCompletions = nestedDiscriminator.properties.a
//@[68:69) [BCP053 (Warning)] The type "Default" does not contain property "a". Available properties include "apiProperties", "backupPolicy", "capabilities", "connectorOffer", "consistencyPolicy", "cors", "createMode", "databaseAccountOfferType", "disableKeyBasedMetadataWriteAccess", "documentEndpoint", "enableAnalyticalStorage", "enableAutomaticFailover", "enableCassandraConnector", "enableFreeTier", "enableMultipleWriteLocations", "failoverPolicies", "instanceId", "ipRules", "isVirtualNetworkFilterEnabled", "keyVaultKeyUri", "locations", "privateEndpointConnections", "provisioningState", "publicNetworkAccess", "readLocations", "restoreParameters", "virtualNetworkRules", "writeLocations". |a|
// #completionTest(73) -> defaultCreateModeProperties
var nestedDiscriminatorCompletions2 = nestedDiscriminator['properties'].a
//@[72:73) [BCP053 (Warning)] The type "Default" does not contain property "a". Available properties include "apiProperties", "backupPolicy", "capabilities", "connectorOffer", "consistencyPolicy", "cors", "createMode", "databaseAccountOfferType", "disableKeyBasedMetadataWriteAccess", "documentEndpoint", "enableAnalyticalStorage", "enableAutomaticFailover", "enableCassandraConnector", "enableFreeTier", "enableMultipleWriteLocations", "failoverPolicies", "instanceId", "ipRules", "isVirtualNetworkFilterEnabled", "keyVaultKeyUri", "locations", "privateEndpointConnections", "provisioningState", "publicNetworkAccess", "readLocations", "restoreParameters", "virtualNetworkRules", "writeLocations". |a|
// #completionTest(69) -> defaultCreateModeProperties
var nestedDiscriminatorCompletions3 = nestedDiscriminator.properties.
//@[69:69) [BCP020 (Error)] Expected a function or property name at this location. ||
// #completionTest(72) -> defaultCreateModeProperties
var nestedDiscriminatorCompletions4 = nestedDiscriminator['properties'].
//@[72:72) [BCP020 (Error)] Expected a function or property name at this location. ||

// #completionTest(79) -> defaultCreateModeIndexes
var nestedDiscriminatorArrayIndexCompletions = nestedDiscriminator.properties[a]
//@[78:79) [BCP057 (Error)] The name "a" does not exist in the current context. |a|

// sample resource to validate completions on the next declarations
resource nestedPropertyAccessOnConditional 'Microsoft.Compute/virtualMachines@2020-06-01' = if(true) {
  location: 'test'
  name: 'test'
  properties: {
    additionalCapabilities: {
      
    }
  }
}
// this validates that we can get nested property access completions on a conditional resource
//#completionTest(56) -> vmProperties
var sigh = nestedPropertyAccessOnConditional.properties.
//@[56:56) [BCP020 (Error)] Expected a function or property name at this location. ||

resource selfScope 'My.Rp/mockResource@2020-12-01' = {
//@[19:50) [BCP081 (Warning)] Resource type "My.Rp/mockResource@2020-12-01" does not have types available. |'My.Rp/mockResource@2020-12-01'|
  name: 'selfScope'
  scope: selfScope
//@[9:18) [BCP079 (Error)] This expression is referencing its own declaration, which is not allowed. |selfScope|
}

var notAResource = {
  im: 'not'
  a: 'resource!'
}
resource invalidScope 'My.Rp/mockResource@2020-12-01' = {
//@[22:53) [BCP081 (Warning)] Resource type "My.Rp/mockResource@2020-12-01" does not have types available. |'My.Rp/mockResource@2020-12-01'|
  name: 'invalidScope'
  scope: notAResource
//@[9:21) [BCP036 (Error)] The property "scope" expected a value of type "resource" but the provided value is of type "object". |notAResource|
}

resource invalidScope2 'My.Rp/mockResource@2020-12-01' = {
//@[23:54) [BCP081 (Warning)] Resource type "My.Rp/mockResource@2020-12-01" does not have types available. |'My.Rp/mockResource@2020-12-01'|
  name: 'invalidScope2'
  scope: resourceGroup()
}

resource invalidScope3 'My.Rp/mockResource@2020-12-01' = {
//@[23:54) [BCP081 (Warning)] Resource type "My.Rp/mockResource@2020-12-01" does not have types available. |'My.Rp/mockResource@2020-12-01'|
  name: 'invalidScope3'
  scope: subscription()
}

resource invalidDuplicateName1 'Mock.Rp/mockResource@2020-01-01' = {
//@[31:64) [BCP081 (Warning)] Resource type "Mock.Rp/mockResource@2020-01-01" does not have types available. |'Mock.Rp/mockResource@2020-01-01'|
  name: 'invalidDuplicateName'
//@[8:30) [BCP121 (Error)] Resources: "invalidDuplicateName1", "invalidDuplicateName2", "invalidDuplicateName3" are defined with this same name in a file. Rename them or split into different modules. |'invalidDuplicateName'|
}
resource invalidDuplicateName2 'Mock.Rp/mockResource@2020-01-01' = {
//@[31:64) [BCP081 (Warning)] Resource type "Mock.Rp/mockResource@2020-01-01" does not have types available. |'Mock.Rp/mockResource@2020-01-01'|
  name: 'invalidDuplicateName'
//@[8:30) [BCP121 (Error)] Resources: "invalidDuplicateName1", "invalidDuplicateName2", "invalidDuplicateName3" are defined with this same name in a file. Rename them or split into different modules. |'invalidDuplicateName'|
}
resource invalidDuplicateName3 'Mock.Rp/mockResource@2019-01-01' = {
//@[31:64) [BCP081 (Warning)] Resource type "Mock.Rp/mockResource@2019-01-01" does not have types available. |'Mock.Rp/mockResource@2019-01-01'|
  name: 'invalidDuplicateName'
//@[8:30) [BCP121 (Error)] Resources: "invalidDuplicateName1", "invalidDuplicateName2", "invalidDuplicateName3" are defined with this same name in a file. Rename them or split into different modules. |'invalidDuplicateName'|
}

resource validResourceForInvalidExtensionResourceDuplicateName 'Mock.Rp/mockResource@2020-01-01' = {
//@[63:96) [BCP081 (Warning)] Resource type "Mock.Rp/mockResource@2020-01-01" does not have types available. |'Mock.Rp/mockResource@2020-01-01'|
  name: 'validResourceForInvalidExtensionResourceDuplicateName'
}

resource invalidExtensionResourceDuplicateName1 'Mock.Rp/mockExtResource@2020-01-01' = {
//@[48:84) [BCP081 (Warning)] Resource type "Mock.Rp/mockExtResource@2020-01-01" does not have types available. |'Mock.Rp/mockExtResource@2020-01-01'|
  name: 'invalidExtensionResourceDuplicateName'
//@[8:47) [BCP121 (Error)] Resources: "invalidExtensionResourceDuplicateName1", "invalidExtensionResourceDuplicateName2" are defined with this same name in a file. Rename them or split into different modules. |'invalidExtensionResourceDuplicateName'|
  scope: validResourceForInvalidExtensionResourceDuplicateName
}

resource invalidExtensionResourceDuplicateName2 'Mock.Rp/mockExtResource@2019-01-01' = {
//@[48:84) [BCP081 (Warning)] Resource type "Mock.Rp/mockExtResource@2019-01-01" does not have types available. |'Mock.Rp/mockExtResource@2019-01-01'|
  name: 'invalidExtensionResourceDuplicateName'
//@[8:47) [BCP121 (Error)] Resources: "invalidExtensionResourceDuplicateName1", "invalidExtensionResourceDuplicateName2" are defined with this same name in a file. Rename them or split into different modules. |'invalidExtensionResourceDuplicateName'|
  scope: validResourceForInvalidExtensionResourceDuplicateName
}

@concat('foo', 'bar')
//@[1:7) [BCP127 (Error)] Function "concat" cannot be used as a resource decorator. |concat|
@secure()
//@[1:7) [BCP127 (Error)] Function "secure" cannot be used as a resource decorator. |secure|
resource invalidDecorator 'Microsoft.Foo/foos@2020-02-02-alpha'= {
//@[26:63) [BCP081 (Warning)] Resource type "Microsoft.Foo/foos@2020-02-02-alpha" does not have types available. |'Microsoft.Foo/foos@2020-02-02-alpha'|
  name: 'invalidDecorator'
}

resource cyclicRes 'Mock.Rp/mockExistingResource@2020-01-01' = {
//@[19:60) [BCP081 (Warning)] Resource type "Mock.Rp/mockExistingResource@2020-01-01" does not have types available. |'Mock.Rp/mockExistingResource@2020-01-01'|
  name: 'cyclicRes'
  scope: cyclicRes
//@[9:18) [BCP079 (Error)] This expression is referencing its own declaration, which is not allowed. |cyclicRes|
}

resource cyclicExistingRes 'Mock.Rp/mockExistingResource@2020-01-01' existing = {
//@[27:68) [BCP081 (Warning)] Resource type "Mock.Rp/mockExistingResource@2020-01-01" does not have types available. |'Mock.Rp/mockExistingResource@2020-01-01'|
  name: 'cyclicExistingRes'
  scope: cyclicExistingRes
//@[9:26) [BCP079 (Error)] This expression is referencing its own declaration, which is not allowed. |cyclicExistingRes|
}

// loop parsing cases
resource expectedForKeyword 'Microsoft.Storage/storageAccounts@2019-06-01' = []
//@[78:79) [BCP012 (Error)] Expected the "for" keyword at this location. |]|

resource expectedForKeyword2 'Microsoft.Storage/storageAccounts@2019-06-01' = [f]
//@[79:80) [BCP012 (Error)] Expected the "for" keyword at this location. |f|

resource expectedLoopVar 'Microsoft.Storage/storageAccounts@2019-06-01' = [for]
//@[75:78) [BCP138 (Error)] Loops are not currently supported. |for|
//@[78:79) [BCP136 (Error)] Expected a loop variable identifier at this location. |]|

resource expectedInKeyword 'Microsoft.Storage/storageAccounts@2019-06-01' = [for x]
//@[77:80) [BCP138 (Error)] Loops are not currently supported. |for|
//@[82:83) [BCP012 (Error)] Expected the "in" keyword at this location. |]|

resource expectedInKeyword2 'Microsoft.Storage/storageAccounts@2019-06-01' = [for x b]
//@[78:81) [BCP138 (Error)] Loops are not currently supported. |for|
//@[84:85) [BCP012 (Error)] Expected the "in" keyword at this location. |b|
//@[85:86) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. |]|

resource expectedArrayExpression 'Microsoft.Storage/storageAccounts@2019-06-01' = [for x in]
//@[83:86) [BCP138 (Error)] Loops are not currently supported. |for|
//@[91:92) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. |]|

resource expectedColon 'Microsoft.Storage/storageAccounts@2019-06-01' = [for x in y]
//@[73:76) [BCP138 (Error)] Loops are not currently supported. |for|
//@[82:83) [BCP057 (Error)] The name "y" does not exist in the current context. |y|
//@[83:84) [BCP018 (Error)] Expected the ":" character at this location. |]|

resource expectedLoopBody 'Microsoft.Storage/storageAccounts@2019-06-01' = [for x in y:]
//@[76:79) [BCP138 (Error)] Loops are not currently supported. |for|
//@[85:86) [BCP057 (Error)] The name "y" does not exist in the current context. |y|
//@[87:88) [BCP009 (Error)] Expected a literal value, an array, an object, a parenthesized expression, or a function call at this location. |]|

// loop semantic analysis cases
var emptyArray = []
resource wrongLoopBodyType 'Microsoft.Storage/storageAccounts@2019-06-01' = [for x in emptyArray:4]
//@[77:80) [BCP138 (Error)] Loops are not currently supported. |for|
//@[97:98) [BCP033 (Error)] Expected a value of type "Microsoft.Storage/storageAccounts" but the provided value is of type "int". |4|

// errors in the array expression
resource arrayExpressionErrors 'Microsoft.Storage/storageAccounts@2019-06-01' = [for account in union([], 2): {
//@[81:84) [BCP138 (Error)] Loops are not currently supported. |for|
//@[106:107) [BCP070 (Error)] Argument of type "int" is not assignable to parameter of type "array". |2|
}]

// wrong array type
var notAnArray = true
resource wrongArrayType 'Microsoft.Storage/storageAccounts@2019-06-01' = [for account in notAnArray: {
//@[74:77) [BCP138 (Error)] Loops are not currently supported. |for|
//@[89:99) [BCP137 (Error)] Loop expected an expression of type "array" but the provided value is of type "bool". |notAnArray|
}]

// missing required properties
resource missingRequiredProperties 'Microsoft.Storage/storageAccounts@2019-06-01' = [for account in []: {
//@[9:34) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "kind", "location", "name", "sku". |missingRequiredProperties|
//@[85:88) [BCP138 (Error)] Loops are not currently supported. |for|
}]

// fewer missing required properties and a wrong property
resource missingFewerRequiredProperties 'Microsoft.Storage/storageAccounts@2019-06-01' = [for account in []: {
//@[9:39) [BCP035 (Error)] The specified "resource" declaration is missing the following required properties: "kind", "sku". |missingFewerRequiredProperties|
//@[90:93) [BCP138 (Error)] Loops are not currently supported. |for|
  name: account
  location: 'eastus42'
  properties: {
    wrong: 'test'
//@[4:9) [BCP038 (Warning)] The property "wrong" is not allowed on objects of type "StorageAccountPropertiesCreateParameters". Permissible properties include "accessTier", "allowBlobPublicAccess", "azureFilesIdentityBasedAuthentication", "customDomain", "encryption", "isHnsEnabled", "largeFileSharesState", "minimumTlsVersion", "networkAcls", "routingPreference", "supportsHttpsTrafficOnly". |wrong|
  }
}]

// wrong property inside the nested property loop
resource wrongPropertyInNestedLoop 'Microsoft.Network/virtualNetworks@2020-06-01' = [for i in range(0, 3): {
//@[85:88) [BCP138 (Error)] Loops are not currently supported. |for|
  name: 'vnet-${i}'
  properties: {
    subnets: [for j in range(0, 4): {
//@[14:17) [BCP138 (Error)] Loops are not currently supported. |for|
      doesNotExist: 'test'
//@[6:18) [BCP038 (Warning)] The property "doesNotExist" is not allowed on objects of type "Subnet". Permissible properties include "id", "properties". |doesNotExist|
      name: 'subnet-${i}-${j}'
    }]
  }
}]

// duplicate identifiers within the loop
// (these duplicates are self-contained - usage of i above is allowed)
resource duplicateIdentifiersWithinLoop 'Microsoft.Network/virtualNetworks@2020-06-01' = [for i in range(0, 3): {
//@[90:93) [BCP138 (Error)] Loops are not currently supported. |for|
//@[94:95) [BCP028 (Error)] Identifier "i" is declared multiple times. Remove or rename the duplicates. |i|
  name: 'vnet-${i}'
  properties: {
    subnets: [for i in range(0, 4): {
//@[14:17) [BCP138 (Error)] Loops are not currently supported. |for|
//@[18:19) [BCP028 (Error)] Identifier "i" is declared multiple times. Remove or rename the duplicates. |i|
      name: 'subnet-${i}-${i}'
    }]
  }
}]

// duplicate identifers in global and single loop scope
var someDuplicate = 'hello'
//@[4:17) [BCP028 (Error)] Identifier "someDuplicate" is declared multiple times. Remove or rename the duplicates. |someDuplicate|
resource duplicateInGlobalAndOneLoop 'Microsoft.Network/virtualNetworks@2020-06-01' = [for someDuplicate in range(0, 3): {
//@[87:90) [BCP138 (Error)] Loops are not currently supported. |for|
//@[91:104) [BCP028 (Error)] Identifier "someDuplicate" is declared multiple times. Remove or rename the duplicates. |someDuplicate|
  name: 'vnet-${someDuplicate}'
  properties: {
    subnets: [for i in range(0, 4): {
//@[14:17) [BCP138 (Error)] Loops are not currently supported. |for|
      name: 'subnet-${i}-${i}'
    }]
  }
}]

// duplicate in global and multiple loop scopes
var otherDuplicate = 'hello'
//@[4:18) [BCP028 (Error)] Identifier "otherDuplicate" is declared multiple times. Remove or rename the duplicates. |otherDuplicate|
resource duplicateInGlobalAndTwoLoops 'Microsoft.Network/virtualNetworks@2020-06-01' = [for otherDuplicate in range(0, 3): {
//@[9:37) [BCP028 (Error)] Identifier "duplicateInGlobalAndTwoLoops" is declared multiple times. Remove or rename the duplicates. |duplicateInGlobalAndTwoLoops|
//@[88:91) [BCP138 (Error)] Loops are not currently supported. |for|
//@[92:106) [BCP028 (Error)] Identifier "otherDuplicate" is declared multiple times. Remove or rename the duplicates. |otherDuplicate|
  name: 'vnet-${otherDuplicate}'
  properties: {
    subnets: [for otherDuplicate in range(0, 4): {
//@[14:17) [BCP138 (Error)] Loops are not currently supported. |for|
//@[18:32) [BCP028 (Error)] Identifier "otherDuplicate" is declared multiple times. Remove or rename the duplicates. |otherDuplicate|
      name: 'subnet-${otherDuplicate}'
    }]
  }
}]

// joining the other duplicates above (we should not be having multiple errors on the same identifier being duplicated)
var someDuplicate = true
//@[4:17) [BCP028 (Error)] Identifier "someDuplicate" is declared multiple times. Remove or rename the duplicates. |someDuplicate|
var otherDuplicate = []
//@[4:18) [BCP028 (Error)] Identifier "otherDuplicate" is declared multiple times. Remove or rename the duplicates. |otherDuplicate|
resource duplicateInGlobalAndTwoLoops 'Microsoft.Network/virtualNetworks@2020-06-01' = [for someDuplicate in range(0, 3): {
//@[9:37) [BCP028 (Error)] Identifier "duplicateInGlobalAndTwoLoops" is declared multiple times. Remove or rename the duplicates. |duplicateInGlobalAndTwoLoops|
//@[88:91) [BCP138 (Error)] Loops are not currently supported. |for|
//@[92:105) [BCP028 (Error)] Identifier "someDuplicate" is declared multiple times. Remove or rename the duplicates. |someDuplicate|
  name: 'vnet-${someDuplicate}'
  properties: {
    subnets: [for otherDuplicate in range(0, 4): {
//@[14:17) [BCP138 (Error)] Loops are not currently supported. |for|
//@[18:32) [BCP028 (Error)] Identifier "otherDuplicate" is declared multiple times. Remove or rename the duplicates. |otherDuplicate|
      name: 'subnet-${otherDuplicate}-${someDuplicate}'
    }]
  }
}]

/*
  valid loop cases - this should be moved to Resources_* test case after codegen works
*/ 
var storageAccounts = [
  {
    name: 'one'
    location: 'eastus2'
  }
  {
    name: 'two'
    location: 'westus'
  }
]
// just a storage account loop
resource storageResources 'Microsoft.Storage/storageAccounts@2019-06-01' = [for account in storageAccounts: {
//@[76:79) [BCP138 (Error)] Loops are not currently supported. |for|
  name: account.name
  location: account.location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}]
// using the same loop variable in a new language scope should be allowed
resource premiumStorages 'Microsoft.Storage/storageAccounts@2019-06-01' = [for account in storageAccounts: {
//@[75:78) [BCP138 (Error)] Loops are not currently supported. |for|
  name: account.name
  location: account.location
  sku: {
    name: 'Premium_LRS'
  }
  kind: 'StorageV2'
}]
// basic nested loop
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = [for i in range(0, 3): {
//@[64:67) [BCP138 (Error)] Loops are not currently supported. |for|
  name: 'vnet-${i}'
  properties: {
    subnets: [for j in range(0, 4): {
//@[14:17) [BCP138 (Error)] Loops are not currently supported. |for|
      name: 'subnet-${i}-${j}'
    }]
  }
}]

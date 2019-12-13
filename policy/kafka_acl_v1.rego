package kafka_acl_v1

import data.common
import data.acls

default authorized = false


has_member[pol_id] {
	principal := split(acls[pol_id].entry.principal, ":")
    input.session.principal.principalType == principal[0]
    input.session.principal.name == principal[1]
}

has_resource[pol_id] {
	resource := acls[pol_id].pattern
	resource.patternType == "LITERAL"
	common.value_match(input.resource.name, resource.name)
	input.resourceType.name == resource.resourceType
}

has_resource[pol_id] {
	resource := acls[pol_id].pattern
	common.not_wildcard(resource.name)
	resource.patternType == "PREFIXED"
	input.resourceType.name == resource.resourceType
	startswith(input.resource.name, resource.name)
}

#### NOT Supported - Wildcard with prefix

has_action[pol_id] {
	input.operation.name == acls[pol_id].entry.action
}

match[[effect, pol_id]] {
	effect := acls[pol_id].entry.permissionType
	has_member[pol_id]
	has_action[pol_id]
	has_resource[pol_id]
}

allow {
	match[["allow", _]]
}

deny {
	match[["deny", _]]
}

authorized {
	allow
	not deny
}
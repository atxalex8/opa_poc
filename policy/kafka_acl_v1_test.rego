package kafka_acl_v1

###############  has_member #########################################

test_has_member_01 {
	has_member.polid with data.acls as {"polid": {"entry": { "principal": "t:z" }}}
		 with input.session as { "principal": { "principalType": "t", "name" : "z" } }
}

test_has_member_not_01 {
	not has_member.polid with data.acls as {"polid": {"entry": { "principal": "t1:z" }}}
		 with input.session as { "principal": { "principalType": "t", "name" : "z" } }
}

test_has_member_not_02 {
	not has_member.polid with data.acls as {"polid": {"entry": { "principal": "t:z1" }}}
		 with input.session as { "principal": { "principalType": "t", "name" : "z" } }
}


###############  has_resource #########################################

test_has_resource_literal_no_wildcard_01 {
 	has_resource.polid with data.acls as {"polid": {"pattern": {"resourceType": "t", "name": "n", "patternType": "LITERAL"}}}
 		 with input as { "resourceType" : {"name" : "t"}, "resource": {"name" : "n" } }
}

test_has_resource_prefix_no_wildcard_01 {
 	has_resource.polid with data.acls as {"polid": {"pattern": {"resourceType": "t", "name": "n", "patternType": "PREFIXED"}}}
 		 with input as { "resourceType" : {"name" : "t"}, "resource": {"name" : "n1234" } }
}

test_has_resource_patterntype_no_wildcard_01 {
 	not has_resource.polid with data.acls as {"polid": {"pattern": {"resourceType": "t", "name": "n", "patternType": "UNKNOWN"}}}
 		 with input as { "resourceType" : {"name" : "t"}, "resource": {"name" : "n" } }
}

test_has_resource_literal_wildcard_01 {
 	has_resource.polid with data.acls as {"polid": {"pattern": {"resourceType": "t", "name": "*", "patternType": "LITERAL"}}}
 		 with input as { "resourceType" : {"name" : "t"}, "resource": {"name" : "n" } }
}

test_has_resource_literal_wildcard_02 {
 	has_resource.polid with data.acls as {"polid": {"pattern": {"resourceType": "t", "name": "c*t", "patternType": "LITERAL"}}}
 		 with input as { "resourceType" : {"name" : "t"}, "resource": {"name" : "cat" } }
}

test_has_resource_literal_wildcard_03 {
 	has_resource.polid with data.acls as {"polid": {"pattern": {"resourceType": "t", "name": "*t", "patternType": "LITERAL"}}}
 		 with input as { "resourceType" : {"name" : "t"}, "resource": {"name" : "nt" } }
}
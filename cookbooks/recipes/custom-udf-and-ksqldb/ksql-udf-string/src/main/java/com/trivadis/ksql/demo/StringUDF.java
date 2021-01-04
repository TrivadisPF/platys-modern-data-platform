package com.trivadis.ksql.demo;

import io.confluent.ksql.function.udf.Udf;
import io.confluent.ksql.function.udf.UdfDescription;
import io.confluent.ksql.function.udf.UdfParameter;
import org.apache.commons.lang3.StringUtils;

@UdfDescription(name = "del_whitespace", description = "Deletes all whitespaces from a String")
public class StringUDF {
	@Udf(description = "Deletes all whitespaces from a String")
	public String adjacentHash(@UdfParameter(value="string", description = "the string to apply the function on") String value) {
		return StringUtils.deleteWhitespace(value);
	}


}

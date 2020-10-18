/* See LICENSE file for copyright and license details. */
#include <stddef.h>
#include <stdio.h>
#include <string.h>

#include "util.h"

static struct {
	char         *identifier;
	char         *tablename;
	struct range *table;
	size_t        tablelen;
} properties[] = {
	{
		.identifier = "Extended_Pictographic",
		.tablename  = "extpict_table",
	},
};

int
process_line(char **field, size_t nfields, char *comment)
{
	size_t i;
	struct range r;

	(void)comment;

	if (nfields < 2) {
		return 1;
	}

	for (i = 0; i < LEN(properties); i++) {
		if (!strcmp(field[1], properties[i].identifier)) {
			if (range_parse(field[0], &r)) {
				return 1;
			}
			range_list_append(&(properties[i].table),
			                  &(properties[i].tablelen), &r);
			break;
		}
	}

	return 0;
}

int
main(void)
{
	size_t i, j;

	printf("/* Automatically generated by data/emo */\n"
	       "#include <stdint.h>\n");

	parse_input(process_line);

	for (i = 0; i < LEN(properties); i++) {
		printf("\nstatic const uint32_t %s[][2] = {\n",
		       properties[i].tablename);
		for (j = 0; j < properties[i].tablelen; j++) {
			printf("\t{ UINT32_C(0x%06X), UINT32_C(0x%06X) },\n",
			       properties[i].table[j].lower,
			       properties[i].table[j].upper);
		}
		printf("};\n");
	}

	return 0;
}
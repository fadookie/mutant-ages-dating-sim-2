import re
import codemod

# print(dir(codemod));

# numCalls = 0
# def patchDoc(document):
# # Patch(start_line_number, end_line_number=None, new_lines=None, path=None)
#     print(dir(document))
#     return None
#     # return codemod.Patch(0, new_lines='*')
# def suggestor(documents):
#     # print(f'Call[{numCalls}]:{documents}')
#     ++numCalls
#     patches = map(patchDoc, documents)
#     # print(list(patches))
#     return patches

# """
# @param line_filter          Given a line, returns True or False.  If False,
#                             a line is ignored (as if line_transformation
#                             returned the line itself for that line).
# """
# def custom_line_filter(line):
#   return True


def base_suggestor(regex, line_transformation_factory, ignore_case=False,
                   line_filter=None):
    if isinstance(regex, str):
        if ignore_case is False:
            regex = re.compile(regex)
        else:
            regex = re.compile(regex, re.IGNORECASE)

    line_transformation = line_transformation_factory(regex)
    return codemod.line_transformation_suggestor(line_transformation,
                                                 line_filter)


def page_comment_line_transform(regex):
    def substitution(matchobj):
        new_page_num = int(matchobj.group(1)) + 1
        return f' //{new_page_num}'

    return lambda line: regex.sub(substitution, line)


def link_line_transform(regex):
    def substitution(matchobj):
        new_page_num = int(matchobj.group(1)) + 1
        return f' = {new_page_num}'

    return lambda line: regex.sub(substitution, line)


suggestors = [
  # , ignore_case=False, line_filter=custom_line_filter)
  base_suggestor(r'(?<=page)\s*//(\d+)', page_comment_line_transform),
  base_suggestor(r'(?<=nextpage)\s*=\s*(\d+)', link_line_transform),
  base_suggestor(r'(?<=link)\s*=\s*(\d+)', link_line_transform),
]


for suggestor in suggestors:
    codemod.Query(
      suggestor,
      root_directory='../raw/dialogue',
      path_filter=codemod.path_filter(
        extensions=['udsf']
      ),
    ).run_interactive()

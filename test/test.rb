require './test_suite'
ENV['JEKYLL_ENV'] = 'test'

@failures = []
build
test_dirs('Site build', '_site', '_expected')

print_results

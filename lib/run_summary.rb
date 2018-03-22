require_relative 'github_jobs'

OUTFILE = File.dirname(__FILE__) + '/tmp/out.json'

summary = GitHubJobs::Summary.new.generate_for_defaults

File.write(OUTFILE, summary)

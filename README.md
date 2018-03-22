# GitHubJobs

#### A handy Ruby wrapper for the [GitHub jobs API](https://jobs.github.com/api)

___

## Installation
`bundle install` to download any of the required Ruby gems not already in your environment.

## Example usage
This program will generate a JSON object for jobs from the GitHub Jobs API, broken down by location, by programming language, and by years of experience. (A sample of the output can be seen at the bottom of this page.)

To run at the command line using `irb`, from the root of this directory run

`irb`

`require './lib/github_jobs.rb'`

`GitHubJobs::Summary.new.generate_for_defaults`

The JSON may not look great in the terminal. Alternately, we can instead (not in the `irb` console) run

`ruby lib/run_summary.rb`

This will run the file at that location. The JSON generated will be written to a file and can be inspected at `/lib/tmp/out.json`.


## Tests
`ruby test/test.rb` from the root directory will run the entire test suite.

Tests are written with [minitest](https://github.com/seattlerb/minitest), with stubbed data using [webmock](https://github.com/bblimke/webmock).

### Known issues and future features

* Future versions should allow passing of other locations or languages for the summary.

* The Summary class is not well tested on its own, only through the unit tests of its dependent methods. A better integration suite would be desirable.

#### Challenges

* Stubbing data for tests was fun/weird because I had not used this particular mocking library before. I screwed up quite a few tries before getting it right.

* I moved bits of my code around quite a bit and broke expected file paths now and then. In the end I realized it would have probably been more appropriate to generate a Gem-like file structure from the beginning and build code inside of that, but I wanted to deal with something a bit more compact from the beginning.

* I borked the hash-loop construction in the Summary class quite a bit toward the end -- I don't know why XD. After a bit I just started over and it worked fine.

#### Areas of the code I am proud of

* The tests are not perfect but I really enjoyed writing them. Getting the mocks in place with only a little time felt good.

* I felt pretty good about the overall structure of the classes and methods. I'm sure looking back on it in a week or two I'll scratch my head and wonder why, but for now, it felt pretty right.

* Any day I get to use the double splat operator is a good day.

#### Areas of the code I am least proud of

* I feel like there's a good bit of general OO refactor that needs done.

* A more robust set of tests is needed, for sure.

* I would have like to package this up as a rubygem for easier reuse.

* In the end it was a bit anticlimatic because of how few job search results there were for each location and language.

#### Tradeoffs

* Time was the biggest factor for me, so I felt rushed with every design decision. I'm sure with more experience, those decisions will come a lot more quickly and naturally. Toward the end, I felt like I was cutting corners and being a bit sloppy in my code.

#### Example JSON output

```
{  
   "Boston":{  
      "Go":{  
         "0-2 years of experience":"0 out of 3 jobs",
         "3-5 years of experience":"0 out of 3 jobs",
         "5+ years of experience":"2 out of 3 jobs"
      },
      "Python":{  
         "0-2 years of experience":"0 out of 3 jobs",
         "3-5 years of experience":"0 out of 3 jobs",
         "5+ years of experience":"2 out of 3 jobs"
      },
      "React":{  
         "0-2 years of experience":"0 out of 3 jobs",
         "3-5 years of experience":"0 out of 3 jobs",
         "5+ years of experience":"2 out of 3 jobs"
      },
      "Ruby":{  
         "0-2 years of experience":"0 out of 3 jobs",
         "3-5 years of experience":"0 out of 3 jobs",
         "5+ years of experience":"2 out of 3 jobs"
      }
   },
   "Boulder":{  
      "Go":{  
         "0-2 years of experience":"0 out of 0 jobs",
         "3-5 years of experience":"0 out of 0 jobs",
         "5+ years of experience":"0 out of 0 jobs"
      },
      "Python":{  
         "0-2 years of experience":"0 out of 0 jobs",
         "3-5 years of experience":"0 out of 0 jobs",
         "5+ years of experience":"0 out of 0 jobs"
      },
      "React":{  
         "0-2 years of experience":"0 out of 0 jobs",
         "3-5 years of experience":"0 out of 0 jobs",
         "5+ years of experience":"0 out of 0 jobs"
      },
      "Ruby":{  
         "0-2 years of experience":"0 out of 0 jobs",
         "3-5 years of experience":"0 out of 0 jobs",
         "5+ years of experience":"0 out of 0 jobs"
      }
   },
   "Chicago":{  
      "Go":{  
         "0-2 years of experience":"0 out of 2 jobs",
         "3-5 years of experience":"0 out of 2 jobs",
         "5+ years of experience":"0 out of 2 jobs"
      },
      "Python":{  
         "0-2 years of experience":"0 out of 2 jobs",
         "3-5 years of experience":"0 out of 2 jobs",
         "5+ years of experience":"0 out of 2 jobs"
      },
      "React":{  
         "0-2 years of experience":"0 out of 2 jobs",
         "3-5 years of experience":"0 out of 2 jobs",
         "5+ years of experience":"0 out of 2 jobs"
      },
      "Ruby":{  
         "0-2 years of experience":"0 out of 2 jobs",
         "3-5 years of experience":"0 out of 2 jobs",
         "5+ years of experience":"0 out of 2 jobs"
      }
   },
   "Denver":{  
      "Go":{  
         "0-2 years of experience":"0 out of 0 jobs",
         "3-5 years of experience":"0 out of 0 jobs",
         "5+ years of experience":"0 out of 0 jobs"
      },
      "Python":{  
         "0-2 years of experience":"0 out of 0 jobs",
         "3-5 years of experience":"0 out of 0 jobs",
         "5+ years of experience":"0 out of 0 jobs"
      },
      "React":{  
         "0-2 years of experience":"0 out of 0 jobs",
         "3-5 years of experience":"0 out of 0 jobs",
         "5+ years of experience":"0 out of 0 jobs"
      },
      "Ruby":{  
         "0-2 years of experience":"0 out of 0 jobs",
         "3-5 years of experience":"0 out of 0 jobs",
         "5+ years of experience":"0 out of 0 jobs"
      }
   },
   "Los Angeles":{  
      "Go":{  
         "0-2 years of experience":"0 out of 5 jobs",
         "3-5 years of experience":"0 out of 5 jobs",
         "5+ years of experience":"3 out of 5 jobs"
      },
      "Python":{  
         "0-2 years of experience":"0 out of 5 jobs",
         "3-5 years of experience":"0 out of 5 jobs",
         "5+ years of experience":"3 out of 5 jobs"
      },
      "React":{  
         "0-2 years of experience":"0 out of 5 jobs",
         "3-5 years of experience":"0 out of 5 jobs",
         "5+ years of experience":"3 out of 5 jobs"
      },
      "Ruby":{  
         "0-2 years of experience":"0 out of 5 jobs",
         "3-5 years of experience":"0 out of 5 jobs",
         "5+ years of experience":"3 out of 5 jobs"
      }
   },
   "New York":{  
      "Go":{  
         "0-2 years of experience":"0 out of 15 jobs",
         "3-5 years of experience":"0 out of 15 jobs",
         "5+ years of experience":"3 out of 15 jobs"
      },
      "Python":{  
         "0-2 years of experience":"0 out of 15 jobs",
         "3-5 years of experience":"0 out of 15 jobs",
         "5+ years of experience":"3 out of 15 jobs"
      },
      "React":{  
         "0-2 years of experience":"0 out of 15 jobs",
         "3-5 years of experience":"0 out of 15 jobs",
         "5+ years of experience":"3 out of 15 jobs"
      },
      "Ruby":{  
         "0-2 years of experience":"0 out of 15 jobs",
         "3-5 years of experience":"0 out of 15 jobs",
         "5+ years of experience":"3 out of 15 jobs"
      }
   },
   "San Francisco":{  
      "Go":{  
         "0-2 years of experience":"0 out of 23 jobs",
         "3-5 years of experience":"2 out of 23 jobs",
         "5+ years of experience":"4 out of 23 jobs"
      },
      "Python":{  
         "0-2 years of experience":"0 out of 23 jobs",
         "3-5 years of experience":"2 out of 23 jobs",
         "5+ years of experience":"4 out of 23 jobs"
      },
      "React":{  
         "0-2 years of experience":"0 out of 23 jobs",
         "3-5 years of experience":"2 out of 23 jobs",
         "5+ years of experience":"4 out of 23 jobs"
      },
      "Ruby":{  
         "0-2 years of experience":"0 out of 23 jobs",
         "3-5 years of experience":"2 out of 23 jobs",
         "5+ years of experience":"4 out of 23 jobs"
      }
   }
}
```

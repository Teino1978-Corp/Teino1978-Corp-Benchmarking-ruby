# Benchmarking ruby

The problem:
    Create a hash from an array of objects where the key is the object's `#id` and the value is the `#stuff` method.
    
Known/Suspected caveats:  
* Garbage collection might be happening, making the results lie.
* Not exhaustive of ways to create a hash from an array
* Not exhaustive of ways to call `Benchmark.ips` with code to test. (no strings yet)
* Not able to manually change the number of iterations
* No GC instrumentation/profiling/timing
* This is completely unfair, as I broke the original pattern of calling `#inject` to artificially 'boost' iterations.

When I started working on this benchmark, I didn't notice any GC stop-the-world time, but I'm human. The fastest was to use `#each_with_object` but it was only a hair faster than `#inject` with assign and return.

I realize there are lots of other ways to merge, but the slowest by far is to actually call `#merge` instead of `#merge!`. I intend to rewrite this to be more fair, but that might be pending a fork of `benchmark/ips` from evan phoenix.
## Puppet learnings
Concepts about Puppet. Let here just to remember


### include vs class
 If you add a class to the catalog using include, you can not pass in parameters. This limits the flexibility of the class unless you're using a tool like hiera within the class. However, it provides the flexibility of being able to call a class as many times you want throughout your code. You could write include apt a hundred times, and Puppet would never care because if apt had already been included in the catalog, it would just use the already existing copy...
More info: https://ask.puppet.com/question/1911/include-class-vs-execute-class/?answer=1919#post-id-1919

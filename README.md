# Personal identification using human skin microbiome


## overview
An R-script is the demonstration of personal identification using human skin microbiome that as described in the article 'Environmental bacteria contribute personal identification of human skin microbiome'


## Requirement
We checked this Rscript can work on R version 3.3.2 and Rstdio version 1.1.338


## Usage
The function of "personal_identification" require two kind of argument.

"d.dist.m.query_reference" is the matrix of canberra distance.
The row is the query samples and column is reference samples.
If there is the query sample in the reference samples, this function automatically remove the sample from reference sample when a query sample is calcurated mean of distance with reference each individual's one (reave-of-out).

		A1	A2	...	C2	C3
	A1	0	100	...	200	230
	A2	100	0	...	220	230
	:	:	:		:	:
	C2	200	220	...	0	90
	C3	230	230	...	90	0	

"sample_individual" is relational table of samples and individuals.

	sample	individual 
	A1 	A 
	A2	A
	A3	A
	B1	B
	B2	B
	B3	B
	C1	C
	C2	C
	C3	C 

The function return two kind of argument as list class.

*$matrix show how many each individual's samples are classified to each individuals. Row of this matrix is query, column is reference.

$matrix
  A B C
A 1 0 0
B 0 1 0
C 0 0 1

*$score show accuracy of personal identification which is TP / (TP + FN)

$score
[1] 1


## Installation
$ git clone git@github.com:HikaruWatanabe/human_skin_personal_identification.git


## DEMO
If you want to show demonstration of our Rscript, please install Rstdio and perform our Rscript (line 1 to 84).
 

## Author
created by Hikaru Watanabe at Tokyo Institute of Technology


## License
BSD 3-Clause License

Copyright (c) 2017, HikaruWatanabe
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.








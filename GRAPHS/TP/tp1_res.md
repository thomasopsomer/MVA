### 1.1. What is the purpose of the option parameter in worst_case_blob?

the option in worst_case_blob aim at bringing a "singularity" in the dataset. The functions creates a dataset generated according to gaussien distribution (randn) but then the fct cutomize the last element : 
	X(end,:) = [max(X(:,1)) + gen_pam, 0]
Which mean that the last datapoint component is the max of every others + an additional param with is the option parameter
Consequently if we give a big parameter the last datapoint has a very big norm compared to others, it is very far from every others point (singularity).

### 1.2. What happens when you change the generating parameter of worst_case_blob.m in how_to_choose_espilon.m and run the function? What if the parameter is very large?





#include <iostream>
#include <sstream>
#include <cstdlib>
#include <cstdio>
#include <vector>

using namespace std;

int main(int argc, char* argv[])
{
	stringstream ss;
	ss << argv[1]; int numberofsegments; ss >> numberofsegments; ss.clear();
	ss << argv[2]; int length; ss >> length; ss.clear();

	char seeds[numberofsegments][length];
        char temparray[length];

	int n = 0;
	int temp;

        vector<int> myvec;

	while (n < numberofsegments)
	{
		int i = 0;

		while (i < length)
		{
			temp = getchar();

			if (temp == EOF) 
			{
				cout << "Error: Not enough digits" << endl;
				return -1;
			}

			if (char(temp) != '\n' && char(temp) != ' ')
			{
				seeds[n][i] = char(temp);
				i++;
			}
		}
		n++;
	}


	for (int i = 0 ; i < numberofsegments; i++)
	{
		for (int j = 0; j < length; j++)
		{
                        temparray[j] = seeds[i][j];
		}

                // if (atoi(temparray) < 31328*30081) // Before MG5_aMC_v2_2_3
                if (atoi(temparray) < 30081*30081) // Starting with MG5_aMC_v2_2_3
                {
			myvec.push_back(atoi(temparray));
                }
	}

	for (int i = 0; i < (int)myvec.size(); i++)
	{
		for (int j = 0; j < i; j++)
		{
			if (myvec[i] == myvec[j])
			{
				cout << "WARNING..... The following random seed is repeated!!!! randsom seed: " << myvec[i] << endl;
			}
		}

		cout << myvec[i] << endl;
	}
}

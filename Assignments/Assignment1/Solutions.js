//Questions 2
for(let i=0; i<5; i++)
{
  let ans = '';
  for(let j=0; j<=i; j++)
  {
    ans = ans + '*';
  }
  console.log(ans);
}

//Question 3
for(let i=5; i>0; i--)
{
  let ans = "";
  for(let j=0; j<i; j++)
  {
    ans = ans+'*';
  }
  console.log(ans);
}
*/

//Question 3
for(let i=0; i<9; i=i+2)
{
  let mid = 4;
  let low = mid-(i);
  let high = mid+(i);
  let pattern = "";
  for(let j=0; j<9; j++)
  {
    if(j>low && j<high)
    pattern = pattern + '*';

    else
    pattern = pattern + ' ';
  }
  console.log(pattern);
}

for (let i = 1; i <= 5; i++) 
{
  let pattern = ' '.repeat(5 - i);
  pattern += '*'.repeat(2 * i - 1);
  console.log(pattern);
}

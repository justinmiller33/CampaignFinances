%Finding percentage of in district votes by job


load('2018Donations.mat')
districts(senate2018)

function[districtStatus] = districts(donations)
%Finding if each record was in an in district location
%List of Reps
reps = ["Feeney, Paul","Barrett, Michael J.","Boncore, Joseph Angelo","Brady, Michael D.","Chandler, Harriette L.","Finegold, Barry R.","Comerford, Joanne","Cyr, Julian Andre","Eldridge, James","Fattman, Ryan","Gobi, Anne M.","Hinds, Adam Gray","Keenan, John F.","Kennedy, Edward","Lesser, Eric Phillip","Lewis, Jason","Lovely, Joan","Moore, Michael","O'Connor, Patrick Michael","Pacheco, Marc R.","Rausch, Rebecca Lynne","Rodrigues, Michael J.","Rush, Michael F.","Spilka, Karen","Timilty, Walter F.","Tran, Dean A.","Welch, James T."];

%Parallel list of distNums
distNums = [32,6,1,34,7,14,38,26,11,9,24,37,2,10,39,17,16,8,33,21,13,35,31,12,20,0,19];

%Initialize matrix for each donor
donorDistrict = zeros(height(donations));

%For each rep
for i = 1:length(rep)
    senate2018.District(find(reps(i)==donations.Recipient(i))) == distNums(i)
end

end
%Public v private building off of inDistrict handler and donations (table)
tic

load('donations.mat')
privs = [];
pubs = [];
publicLabels = ["State","City", "Town", "Commonwealth", "School",  "Public", "Jail", "County", "Prison", "Umass", "Massachusetts", "Schools", "Police", "Fire"];
publicLabels = lower(publicLabels);

for i = 1:height(donations)
    public = false;

    if string(donations.RecordTypeDescription(i)) == "Individual"
        
        for j = 1:length(publicLabels)
            if contains(lower(string(donations.Employer(i))),publicLabels(j))
                public = true;
            end
        end
    end
    
    if public
        pubs = [pubs;donations(i,:)] ;
        
    elseif ~ismissing(donations.Employer(i))
        privs = [privs;donations(i,:)];
    
    end
    
end
toc


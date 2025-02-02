%Megan Anderson 
%Professor Jaeggli 
%BMES Project 1 Code 
%Due Novemmber 15th 2024 
close all; clear all; clc; 

%data import 
ANUSR_raw = readmatrix('ANSUR_DATA_2012.xlsx'); 
NHANES_raw = readmatrix('NHANES_DATA_2018.xlsx'); 

%% Part 2 - Data Sorting 
%seperate male and female data 
rowsF = 1798; %female data in rows 1-1798 
rows1 = height(ANUSR_raw);

for i = 1:rowsF %all female rows 
        ANUSR_female(i,:) = ANUSR_raw(i,:);
end 
h = 1; 
for i = rowsF+1:rows1 %all male rows 
    ANUSR_male(h,:) = ANUSR_raw(i,:);
    h = h+1; 
end 

%seperate female data by age 
rows2 = height(ANUSR_female);
%counts for each age category 
j = 1; %20-29
l = 1; %30-39 
m = 1; %40-49 

for k = 1:rows2
    if ANUSR_female(k,2) <= 29
        ANUSR_female_20s(j,:) = ANUSR_female(k,[3 4]); 
        j = j+1; 
    else if ANUSR_female(k,2) <= 39
        ANUSR_female_30s(l,:) = ANUSR_female(k,[3 4]); 
        l = l+1; 
    else 
         ANUSR_female_40s(m,:) = ANUSR_female(k,[3 4]); 
         m = m + 1; 
    end 
    end 
end 

%seperate male data by age 
rows3 = height(ANUSR_male); 
%counts for each age category 
n = 1; %20-29
o = 1; %30-39
p = 1; %40-49

for q = 1:rows3
    if ANUSR_male(q,2) <= 29
        ANUSR_male_20s(n,:) = ANUSR_male(q,[3 4]); 
        n = n+1; 
    else if ANUSR_male(q,2) <= 39
        ANUSR_male_30s(o,:) = ANUSR_male(q,[3 4]); 
        o = o+1; 
    else 
        ANUSR_male_40s(p,:) = ANUSR_male(q,[3 4]); 
        p = p + 1; 
    end 
    end 
end 
%6 matrices (one for each age group) with 2 columnns (measures) in each 
%column 1 of each matrix = weight 
%column 2 of each matrix = height 

%% Part 3 - Normal Distributions of NHANES Data 
mu = NHANES_raw(:,5); %mean 
sigma = NHANES_raw(:,6); %standard deviation
size = [500,1]; %size of data generated 

%Loop to create normal distributions 
for count = 1:height(NHANES_raw)
    normdisNAHES(:,count) = normrnd(mu(count),sigma(count) ,size);
end 

%columns in normdisNAHES matrix: 
% #1 = Female 20-29 Weight 
% #2 = Female 20-29 Height 
% #3 = Female 30-39 Weight 
% #4 = Female 30-39 Height 
% #5 = Female 40-49 Weight 
% #6 = Female 40-49 Height 
% #7 = Male 20-29 Weight 
% #8 = Male 20-29 Height 
% #9 = Male 30-39 Weight 
% #10 = Male 30-39 Height 
% #11 = Male 40-49 Weight 
% #12 = Male 40-49 Height 

%Histogram & Probability Plot of Females 30-39 Weight 
%histogram 
figure(1)
histogram(normdisNAHES(:,3))
xlabel('Weight')
ylabel('Frequency')
title('Frequency of Weight of Normally Distributed Data Set Fabricated for Females Ages 30-39')

%probplot 
figure(2) 
probplot('normal',normdisNAHES(:,3))

%% Part 4 - Boxplots 
%Females 20-29 Weight 
combined_data1 = [ANUSR_female_20s(:,1); normdisNAHES(:,1)]; %NHANES and ANSUR data for this group
group1 = [repmat({'ANUSR Data'}, height(ANUSR_female_20s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(1) = vartestn(combined_data1, group1, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5 

figure(3) 
boxplot(combined_data1, group1,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Female 20-29 Weight')
ylabel ('Weight (lbs)')

%Females 20-29 Height 
combined_data2 = [ANUSR_female_20s(:,2); normdisNAHES(:,2)]; %NHANES and ANSUR data for this group
group2 = [repmat({'ANUSR Data'}, height(ANUSR_female_20s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(2) = vartestn(combined_data2, group2, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(4) 
boxplot(combined_data2, group2,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Female 20-29 Height')
ylabel ('Height (in)')

%Females 30-39 Weight 
combined_data3 = [ANUSR_female_30s(:,1); normdisNAHES(:,3)]; %NHANES and ANSUR data for this group
group3 = [repmat({'ANUSR Data'}, height(ANUSR_female_30s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(3) = vartestn(combined_data3, group3, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(5) 
boxplot(combined_data3, group3,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Female 30-39 Weight')
ylabel ('Weight (lbs)')

%Females 30-39 Height 
combined_data4 = [ANUSR_female_30s(:,2); normdisNAHES(:,4)]; %NHANES and ANSUR data for this group
group4 = [repmat({'ANUSR Data'}, height(ANUSR_female_30s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(4) = vartestn(combined_data4, group4, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(6) 
boxplot(combined_data4, group4,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Female 30-39 Height')
ylabel ('Height (in)')

%Females 40-49 Weight 
combined_data5 = [ANUSR_female_40s(:,1); normdisNAHES(:,5)]; %NHANES and ANSUR data for this group
group5 = [repmat({'ANUSR Data'}, height(ANUSR_female_40s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(5) = vartestn(combined_data5, group5, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(7) 
boxplot(combined_data5, group5,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Female 40-49 Weight')
ylabel ('Weight (lbs)')

%Females 40-49 Height 
combined_data6 = [ANUSR_female_40s(:,2); normdisNAHES(:,6)]; %NHANES and ANSUR data for this group
group6 = [repmat({'ANUSR Data'}, height(ANUSR_female_40s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(6) = vartestn(combined_data6, group6, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(8) 
boxplot(combined_data6, group6,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Female 40-49 Height')
ylabel ('Height (in)')

%Males 20-29 Weight 
combined_data7 = [ANUSR_male_20s(:,1); normdisNAHES(:,7)]; %NHANES and ANSUR data for this group
group7 = [repmat({'ANUSR Data'}, height(ANUSR_male_20s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(7) = vartestn(combined_data7, group7, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(9) 
boxplot(combined_data7, group7,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Male 20-29 Weight')
ylabel ('Weight (lbs)')

%Male 20-29 Height 
combined_data8 = [ANUSR_male_20s(:,2); normdisNAHES(:,8)]; %NHANES and ANSUR data for this group
group8 = [repmat({'ANUSR Data'}, height(ANUSR_male_20s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(8) = vartestn(combined_data8, group8, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(10) 
boxplot(combined_data8, group8,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Male 20-29 Height')
ylabel ('Height (in)')

%Male 30-39 Weight 
combined_data9 = [ANUSR_male_30s(:,1); normdisNAHES(:,9)]; %NHANES and ANSUR data for this group
group9 = [repmat({'ANUSR Data'}, height(ANUSR_male_30s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(9) = vartestn(combined_data9, group9, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(11) 
boxplot(combined_data9, group9,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Male 30-39 Weight')
ylabel ('Weight (lbs)')

%Male 30-39 Height 
combined_data10 = [ANUSR_male_30s(:,2); normdisNAHES(:,10)];%NHANES and ANSUR data for this group
group10 = [repmat({'ANUSR Data'}, height(ANUSR_male_30s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(10) = vartestn(combined_data10, group10, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(12) 
boxplot(combined_data10, group10,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Male 30-39 Height')
ylabel ('Height (in)')

%Male 40-49 Weight 
combined_data11 = [ANUSR_male_40s(:,1); normdisNAHES(:,11)];%NHANES and ANSUR data for this group
group11 = [repmat({'ANUSR Data'}, height(ANUSR_male_40s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(11) = vartestn(combined_data11, group11, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(13) 
boxplot(combined_data11, group11,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Male 40-49 Weight')
ylabel ('Weight (lbs)')

%Male 40-49 Height 
combined_data12 = [ANUSR_male_40s(:,2); normdisNAHES(:,12)];%NHANES and ANSUR data for this group
group12 = [repmat({'ANUSR Data'}, height(ANUSR_male_40s), 1); ...
         repmat({'NHANES Data'}, height(normdisNAHES), 1)]; %repmat to work around arrays of different lengths 
p_levene(12) = vartestn(combined_data12, group12, 'TestType', 'LeveneAbsolute', 'Display', 'off'); %for part 5

figure(14) 
boxplot(combined_data12, group12,'Labels',{'ANUSR Data' 'NHANES Data'}) 
title ('Boxplot of Male 40-49 Height')
ylabel ('Height (in)')

%% Part 5 - Test Statistic 
results_table = cell(12, 6); % Columns: Group, p-value, h-value, Test Used, Confidence Interval

% define groups for table 
groups = {'Female 20-29 Weight', 'Female 20-29 Height', 'Female 30-39 Weight', ...
          'Female 30-39 Height', 'Female 40-49 Weight', 'Female 40-49 Height', ...
          'Male 20-29 Weight', 'Male 20-29 Height', 'Male 30-39 Weight', ...
          'Male 30-39 Height', 'Male 40-49 Weight', 'Male 40-49 Height'}; 

%combine data for loop 
lengths = [height(ANUSR_female_20s); height(ANUSR_female_20s); height(ANUSR_female_30s); height(ANUSR_female_30s); ...
    height(ANUSR_female_40s);height(ANUSR_female_40s);height(ANUSR_male_20s);height(ANUSR_male_20s);height(ANUSR_male_30s);height(ANUSR_male_30s); ...
    height(ANUSR_male_40s);height(ANUSR_male_40s)]; 
%lengths = # of data points of each group of data to combine arrays of different lenghts 
%fills rest of the space in with 0s (below what is needed) 

ANSUR_combined(:,[1:2]) = ANUSR_female_20s; 
ANSUR_combined([1:lengths(3)],[3:4]) = ANUSR_female_30s; 
ANSUR_combined([1:lengths(5)],[5:6]) = ANUSR_female_40s;
ANSUR_combined([1:lengths(7)],[7:8]) = ANUSR_male_20s; 
ANSUR_combined([1:lengths(9)],[9:10]) = ANUSR_male_30s; 
ANSUR_combined([1:lengths(11)],[11:12]) = ANUSR_male_40s;

% t-testing loop 
for i = 1:length(groups)
    % determine appropriate test - p_levene calculated within code for part 4 
        if p_levene(i) > 0.05 %alpha used = 0.05 
            % equal variances --> two sample t-test
            [h, p_value, ci] = ttest2(ANSUR_combined([1:lengths(i)],i), normdisNAHES(:,i), 'Vartype', 'equal');
            test_used = 'Two-Sample t-Test';
        else
            % unequal variances --> Welchus t-test
            [h, p_value, ci] = ttest2(ANSUR_combined(:,i), normdisNAHES(:,i), 'Vartype', 'unequal');
            test_used = 'Welch’s t-Test';
        end
    %add to results table 
    results_table{i, 1} = groups{i}; %name of group
    results_table{i, 2} = p_value; 
    results_table{i, 3} = h;
    results_table{i, 4} = test_used; %two sample t-test or welch's t-test 
    results_table{i, 5} = ci(1); %lower bound of CI 
    results_table{i, 6} = ci(2); %upper bound of CI 

    %display results 
    fprintf('\n\n%s:\n', groups{i});
    fprintf('  Test Used: %s\n', test_used);
    fprintf('  p-value: %e\n', p_value);
    fprintf('  h-value: %d\n', h);
    if contains(test_used, 't-Test')
        fprintf('  Confidence Interval for Mean Difference: [%.4f, %.4f]\n', ci(1), ci(2));
    end
end


% check normality visually - on norm prob plot graph 
for count4 = 1:12 
    figure()
    probplot('normal',ANSUR_combined([1:lengths(count4)],count4))
end 

%% Part 7 - Regeration of NHANES
mu = NHANES_raw(:,5); %same mean as part 3 
sigma = NHANES_raw(:,6); %same stdv as part 3 
size = [500,1]; %same size of norm dis data as part 3 

%loop to run code from part 3 nine times 
for count3 = 1:9
    for count2 = 1:height(NHANES_raw)
        normdis2NAHES(:,count2) = normrnd(mu(count2),sigma(count2) ,size);
        [h, p_value, ci] = ttest2(ANSUR_combined([1:lengths(count2)],count2), normdis2NAHES(:,count2), 'Vartype', 'equal');
        results_table2{count2, count3} = h; 
        %calculates results and stores h-value within inner loop to avoid storing nine 12x500 matrices of values 
    end
end 

%display h-values to compare across re-runs  
disp(results_table2)
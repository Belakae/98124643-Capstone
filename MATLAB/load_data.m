function[com_1,visc,zero] = load_data

file1 = importdata('CoM_1.txt',' ',1);
file2 = importdata('CoM_2.txt',' ',1);
file3 = importdata('CoM_3.txt',' ',1);
file4 = importdata('CoM_4.txt',' ',1);
file5 = importdata('CoM_5.txt',' ',1);
file6 = importdata('CoM_6.txt',' ',1);
file7 = importdata('CoM_7.txt',' ',1);
file8 = importdata('CoM_8.txt',' ',1);
file9 = importdata('CoM_9.txt',' ',1);
file10 = importdata('CoM_10.txt',' ',1);
file11 = importdata('visc.txt',' ',1);
file12 = importdata('zero.txt',' ',1);

com_1 = file1.data;
com_2 = file2.data;
com_3 = file3.data;
com_4 = file4.data;
com_5 = file5.data;
com_6 = file6.data;
com_7 = file7.data;
com_8 = file8.data;
com_9 = file9.data;
com_10 = file10.data;
visc = file11.data;
zero = file12.data;

end
function [gold_seq,balance_g,balance_32,balance_40,balance_24]=build_gold(r,m_seq1,m_seq2)
num_gold=2^r+1;
N=2^r-1;
gold_seq=zeros(num_gold,N);
gold_seq(1,:)=m_seq1;
gold_seq(2,:)=m_seq2;
balance_g=zeros(1,num_gold);
for i=3:num_gold
    j=i-2;
    if(j==1)
        gold_seq(i,:)=mod(m_seq1+m_seq2,2);
    elseif(j==N)
        gold_seq(i,:)=mod(m_seq1+[m_seq2(N) m_seq2(1:N-1)],2);
    else
        gold_seq(i,:)=mod(m_seq1+[m_seq2(j:N) m_seq2(1:j-1)],2);
    end
end
balance_32=0;
balance_40=0;
balance_24=0;
for i=1:num_gold
    balance_one=0;
    balance_zero=0;
    
    for j=1:N
        if(gold_seq(i,j)==1)
            balance_one=balance_one+1;
        elseif(gold_seq(i,j)==0)
            balance_zero=balance_zero+1;
        end
    end
    if(balance_one==32)
        balance_g(i)=1;
        balance_32=balance_32+1;
    elseif(balance_one==40)
        balance_g(i)=2;
        balance_40=balance_40+1;
    elseif(balance_one==24)
        balance_g(i)=3;
        balance_24=balance_24+1;
    end
end
%��ʾ���֣�������֮ǰ�Ĵ������
disp(sprintf('ƽ�����й���%d��',balance_32));
%disp(sprintf('��ƽ�����й���%d��',(63-balance_32)));
%��ʽ���ڷ���ֵ�Ĵ�ӡ��Ϣ
disp(sprintf('��ƽ�����й���%d��',(balance_40+balance_24)));
%��ʽ������ֵ�Ĵ�ӡ��Ϣ

for i=1:num_gold
    disp(sprintf('Gold����%d',i));
    if(balance_g(i)==1)
        disp(sprintf('ƽ������'));
    else
        disp(sprintf('��ƽ������'));
    end
    disp(num2str(gold_seq(i,1:21)));
    disp(num2str(gold_seq(i,22:42)));
    disp(num2str(gold_seq(i,43:N)));
end
use strict;

use File::Copy;

my $newDir="files";
unless(-d $newDir)
{
	mkdir $newDir or die $!;
}

my @allFiles=glob("*");
foreach my $subDir(@allFiles)
{
	if((-d $subDir) && ($subDir ne $newDir))
	{
		opendir(SUB,"./$subDir") or die $!;
		while(my $file=readdir(SUB))
		{
			if($file=~/\.tsv$/)
			{
				#`cp ./$subDir/$file ./$newDir`;
				copy("$subDir/$file","$newDir") or die "Copy failed: $!";
			}
		}
		close(SUB);
	}
}



###Video source: http://study.163.com/u/biowolf
######Video source: https://shop119322454.taobao.com
######�ٿ�����: http://www.biowolf.cn/
######�������䣺2740881706@qq.com
######����΢��: seqBio
######QQȺ:  259208034

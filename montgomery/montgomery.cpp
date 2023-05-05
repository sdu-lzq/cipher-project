#include <iostream>
#include <chrono>
#include <random>
#include <chrono>

#include <NTL/ZZ.h> 
#include <NTL/RR.h> 
#include <NTL/vector.h> 
#pragma comment(lib, "NTL")

using namespace std;
using namespace NTL;

typedef long long int64;
typedef unsigned int uint;
typedef unsigned long long ulong;


unsigned int acc=1024;


void Barrett(ZZ& n, ZZ& a, ZZ& res, uint& acc)
{
	ZZ q;
	uint k = NumBits(n) + acc;
	//由于m的存在，那么k一定要比n的bit数多
	//k的位数加上准确度常量acc，来控制e的大小，acc越大，e越小，准确度越高
	ZZ m = power2_ZZ(k)/n;
	//m = floor(2^k / n)
	q = (m * a) >> k; //q = floor(a/n) = a * m/2^k
	res = a - q * n; //a - q*n
	if (res >= n)
		res -= n;
	//如果出现a约化精度不够的问题，就继续减n
}

class Montgomery
{
private:

	uint RR;
	ZZ R;
	ZZ N;
	ZZ N_inv;//N_inv * N = -1 mod R
	ZZ Z;//零
	ZZ L;//R的掩码
	ZZ m;

public:
	void init(ZZ& N);//初始化模型
	void Map(ZZ& src, ZZ& dst);//将a和b计算aR和bR
	void InvMap(ZZ& src, ZZ& dst);//映射回源数据
	void Mul(ZZ& a, ZZ& b, ZZ& ab);//乘法计算
};


void Montgomery::init(ZZ& N)
{
	if ((N & ZZ(1)) != 1) //N应当是奇数，因为R取的2的幂次
		return;
	this->N = N;
	RR = NumBits(N);
	R = 1;
	R <<= RR; //R = 2^RR
	Z = 0; //零
	L = R - 1; //掩码
	ZZ d, s, t;
	XGCD(d, s, t, N, R); //d=1, s*N = 1 mod R
	N_inv = R - s; //N_inv * N = -1 mod R
}

// a*R mod N
void Montgomery::Map(ZZ& a, ZZ& bar_a)
{
	bar_a = a << RR; //a*R
	bar_a %= N; //a*R mod N
}


// a_bar * R_inv mod N
void Montgomery::InvMap(ZZ& T_bar, ZZ& T)
{
	T = T_bar; //T
	m = T * N_inv; //m = T * (-N_inv)
	m &= L; //m mod R 直接使用掩码实现，提升运算速度
	T += m * N; //T + m*N
	T >>= RR; //(T + m*N) * R_inv
	if (T > N)
		T -= N;
}



//Montgomery乘法
void Montgomery::Mul(ZZ& a, ZZ& b, ZZ& ab)
{
	ab = a * b; //T = a*R * b*R
	m = ab * N_inv; //m = T * (-N_inv)
	m &= L; //m mod R
	ab += m * N; //(T + m*N)
	ab >>= RR; //(T + m*N) * R_inv
	if (ab > N)
		ab -= N;
}


int main()
{
	
	//cout<<NumBits(8);
	Montgomery Mt;
	ZZ a, a_bar;
	ZZ b, b_bar;
	ZZ N;
	ZZ T, T_bar;
	a = conv<ZZ>("24323894044365873031245458094874190260697127092346297087950166767055502066756103674985135219014398461873146257998728876580994851163035308940418012188772011516083950832666018922872358872231370039569050550868528871510631824453955150104525766090960947302291295168400384379272858758446185990427017814868784418247943955951173220092058157789838684940093653433438263353435290612685799208225489854783807432345432279015861508365406389236255392282304878132281460186533368620622532022174486889907015559359312677034829879913780151364357006000515163642357304320352609664610111199020930627479370663299112200614908410209484873267496");
	b = conv<ZZ>("27448743300044676644365010310728600528922326267830707644815065197140037114188323560146810216156374554902660623901255127638403915226580166554878584229922542180781816569299014421171288369865832926956084706649099526748509658227759639976724201291855451951834694093749438734446097641956641623687315538027047148005020789352844990375830372465302395287663480114419627370546866628926188374330233004991531154730113271484473221416757743598844829819103822578573085885928291972268618327238505363722985460686388901301351842796511543139501662881983331002989073499290031327327538970169076297207359643563229083669620115218642415688357");
	N = conv<ZZ>("5772015387518224259553890253146048672866112900670067513151616001646941919018520680429996554900336320775748706152996695949867282879890676789527329270559945623905538572959850278892422749383897089745344266859480614507311264079523002069342269392496739807170589499515024769483334564273384579471656769122081065942730193081912543770989928919864286986113126072418565253655226518533264483860456726493168267243702334984668902810716102927916174377717276047956631114629664539095252628644851754956910324792281941107533126895660572412770497466221698862817803540177608626196335966352214198640798649776496314331219591342531044776877");
	Mt.init(N);
	Mt.Map(a, a_bar);
	Mt.Map(b, b_bar);
	Mt.Mul(a_bar, b_bar, T_bar);
	Mt.InvMap(T_bar, T);
	cout << "a=" << a << endl;
	cout << endl;
	cout << "b=" << b << endl;
	cout << endl;
	cout << "N=" << N << endl;
	cout << endl;
	cout << "The result of Montgomery multiplication is " << T<<endl;
	ZZ res=conv<ZZ>(0);
	cout << endl;
	Barrett(N, a, res, acc);
	cout << "The result of Barrett reduction is " << res<<endl;

}
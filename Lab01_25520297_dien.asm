.data
nhap: .asciiz "Nhap so kWh (0..9999): "
loi: .asciiz "Gia tri khong hop le, nhap lai.\n"
thong_bao: .asciiz "Tien dien: "
dong: .asciiz " dong\n"
nguong: .word 50,100,200,300,400,9999
don_gia: .word 1740,1800,2090,2640,2990,3140
.text
.globl main
main:
 # Phan cong cac thanh ghi:
	# $s0: So kWh dien tieu thu N
	# $s1: Tong tien dien T
	# $s2: Nguong duoi L cua bac dien hien tai
	# $s3: Chi so bac dien i (tu 0 den 5)
	# $s4: Nguong tren U cua bac dien hien tai
	# $s5: Don gia P cua bac dien hien tai
	# $s6: So kWh duoc tinh tien trong bac hien tai
	# $t0: Thanh ghi tam de so sanh va kiem tra dieu kien
	# $t1: Thanh ghi tam luu do lech dia chi (offset) cua mang
	# $t2: Thanh ghi tam luu tien dien cua bac hien tai
	# $v0: Thanh ghi chua ma syscall
	# $a0: Thanh ghi chua doi so cho syscall
nhap_lai:
li $v0,4
la $a0,nhap
syscall
li $v0,5
syscall
move $s0,$v0
li $t1,9999
sltu $t0,$t1,$s0
bne $t0,$zero,khong_hop_le
li $s1,0
li $s2,0
li $s3,0
vong_lap:
slti $t0,$s3,6
beq $t0,$zero,xuat_ket_qua
la $t0,nguong
sll $t1,$s3,2
addu $t0,$t0,$t1
lw $s4,0($t0)
la $t0,don_gia
sll $t1,$s3,2
addu $t0,$t0,$t1
lw $s5,0($t0)
slt $t0,$s4,$s0
bne $t0,$zero,tinh_tron_bac
subu $s6,$s0,$s2
mul $t2,$s6,$s5
addu $s1,$s1,$t2
j xuat_ket_qua
tinh_tron_bac:
subu $s6,$s4,$s2
mul $t2,$s6,$s5
addu $s1,$s1,$t2
move $s2,$s4
addiu $s3,$s3,1
j vong_lap
khong_hop_le:
li $v0,4
la $a0,loi
syscall
j nhap_lai
xuat_ket_qua:
li $v0,4
la $a0,thong_bao
syscall
li $v0,1
move $a0,$s1
syscall
li $v0,4
la $a0,dong
syscall
li $v0,10
syscall

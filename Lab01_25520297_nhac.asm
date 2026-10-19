.data
cao_do: .word 64,64,65,67,67,65,64,62,60,60,62,64,64,62,62
do_dai: .word 2,2,2,2,2,2,2,2,2,2,2,2,3,1,4
so_not: .word 15
mot_nhip: .word 240
nhac_cu: .word 24
chuoi_tong: .asciiz "Tong du kien (ms): "
chuoi_do: .asciiz "Thoi gian do duoc (ms): "
khoang_trang: .asciiz " "
xuong_dong: .asciiz "\n"
.text
.globl main
main:
la $s1, cao_do
la $s2, do_dai
lw $s4, so_not
lw $s5, mot_nhip
lw $s6, nhac_cu
li $s3, 0
li $s7, 0
li $t7, 7
li $v0, 30
syscall
move $s0, $a0
vong_lap:
beq $s3, $s4, ket_thuc
sll $t0, $s3, 2
addu $t1, $s1, $t0
lw $t2, 0($t1)
addu $t3, $t2, $t7
addu $t1, $s2, $t0
lw $t2, 0($t1)
mul $t4, $t2, $s5
addu $s7, $s7, $t4
li $v0, 1
move $a0, $t3
syscall
li $v0, 4
la $a0, khoang_trang
syscall
li $v0, 1
move $a0, $t4
syscall
li $v0, 4
la $a0, xuong_dong
syscall
move $a0, $t3
move $a1, $t4
move $a2, $s6
li $a3, 100
li $v0, 33
syscall
addiu $s3, $s3, 1
j vong_lap
ket_thuc:
li $v0, 30
syscall
subu $t5, $a0, $s0
li $v0, 4
la $a0, chuoi_tong
syscall
li $v0, 1
move $a0, $s7
syscall
li $v0, 4
la $a0, xuong_dong
syscall
li $v0, 4
la $a0, chuoi_do
syscall
li $v0, 1
move $a0, $t5
syscall
li $v0, 4
la $a0, xuong_dong
syscall
li $v0, 10
syscall
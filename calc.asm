	lui   s1,0xFFFFF

switled: # Test led and switch
	lw   s0,0x70(s1) # read switch
	sw   s0,0x60(s1) # write led
	andi s2,s0,0xFF # A
	srli s0,s0,8
	andi s3,s0,0xFF # B
	srli s0,s0,8
	andi s4,s0,0xFF
	srli s4,s4,5 # op

	andi s2,s2,0xFF
	andi s3,s3,0xFF

	# param
	addi a0,x0,0
	addi a1,x0,1
	addi a2,x0,2
	addi a3,x0,3
	addi a4,x0,4
	addi a5,x0,5
	addi a6,x0,6
	addi a7,x0,7
	addi t6,x0,8

	bne s4,a0,Else1
	addi s0,x0,0
	jal x0,Exit
	Else1:
		bne s4,a1,Else2
		add s0,s2,s3
		andi s0,s0,0xFF
		jal x0,Exit
	Else2:
		bne s4,a2,Else3
		sub s0,s2,s3
		andi s0,s0,0xFF
		jal x0,Exit
	Else3:
		bne s4,a3,Else4
		and s0,s2,s3
		andi s0,s0,0xFF
		jal x0,Exit
	Else4:
		bne s4,a4,Else5
		or s0,s2,s3
		andi s0,s0,0xFF
		jal x0,Exit
	Else5:
		bne s4,a5,Else6
		sll s0,s2,s3
		andi s0,s0,0xFF
		jal x0,Exit
	Else6:
		bne s4,a6,Else7
		sra s0,s2,s3
		andi s0,s0,0xFF
		jal x0,Exit
	Else7:
		beq s4,a7,Mulcalc
	Exit:
    	sw s0,0x00(s1)
	jal x0,switled

Mulcalc:
	xori t1,s2,-1
	addi t1,t1,1 # -x ¡®complement
	andi t1,t1,0xFF

	slli t0,s2,9 # x ¡®complement << 8+1
	slli t1,t1,9 # -x ¡®complement << 8+1

	slli s0,s3,1 # part mul

	add t3,x0,x0 # i = 0, to 8

	MLoop:
		bge t3,t6,MDone
		andi t2,s0,0x3 # 0011 choose yi yi+1
		bne t2,a0,MElse1 # 00
		jal x0,MEnd
		MElse1: # 01 plus x ¡®complement
			bne t2,a1,MElse2
			add s0,s0,t0
			jal x0,MEnd
		MElse2: # 10 plus -x ¡®complement
			bne t2,a2,MElse3
			add s0,s0,t1
			jal x0,MEnd
		MElse3: # 11
			bne t2,a3,MEnd
		MEnd:
			slli s0,s0,15
			srai s0,s0,1 # a right shift
			srli s0,s0,15
		addi t3,t3,1 # i++
		jal x0,MLoop
	MDone:
		srai s0,s0,1
	jal x0,Exit

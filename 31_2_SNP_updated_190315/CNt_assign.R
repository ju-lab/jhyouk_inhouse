#subclonality analysis

purity = 0.47
cnt = 2
for(i in 1:1){
  m_allele = i
  vaf = m_allele * purity / (purity*cnt + (1-purity)*2)
  print(i)
  print(vaf)
}
vaf = 0.5 * purity / (purity*cnt + (1-purity)*2)
print(0.5);print(vaf)

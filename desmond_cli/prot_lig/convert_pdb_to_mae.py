import schrodinger.structure as structure

st1 = structure.StructureReader('snapshot.pdb')
st=next(st1)
st.property["s_ffio_ct_type"] = "full_system"
st.property["s_chorus_trajectory_file"] = "desmond-out.idx"

st.write('full_system.mae')


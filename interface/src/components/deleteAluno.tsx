'use client'
import { DeleteAluno } from '@/action/aluno/delete'

export const DeleteAlunoComponent = ({ id }: { id: number }) => {
  const handleDelete = async (
    e: React.MouseEvent<HTMLButtonElement, MouseEvent>,
  ) => {
    e.preventDefault()
    if (confirm('Tem certeza de quer excluir?')) await DeleteAluno(id)
  }
  return (
    <button
      onClick={handleDelete}
      className="py-2 px-4 text-red-600 hover:underline cursor-pointer rounded"
    >
      Remove
    </button>
  )
}
